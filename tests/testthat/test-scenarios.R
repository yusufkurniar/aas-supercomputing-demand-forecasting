
# Scenario calculation reference tests
# References:
# technical-analysis/10_scenario_forecasting.qmd
# report/report.qmd, Section 3.6
#
# Synthetic inputs are used to validate the arithmetic.
# These tests do not rerun the complete Chapter 10 pipeline.

allocate_demand <- function(total_demand, shares) {
  stopifnot(
    length(total_demand) == 1,
    is.finite(total_demand),
    total_demand >= 0,
    is.numeric(shares),
    length(shares) > 0,
    all(is.finite(shares)),
    all(shares >= 0),
    abs(sum(shares) - 1) < 1e-8
  )

  total_demand * shares
}

calculate_shares <- function(allocations) {
  stopifnot(
    is.numeric(allocations),
    length(allocations) > 0,
    all(is.finite(allocations)),
    all(allocations >= 0),
    sum(allocations) > 0
  )

  allocations / sum(allocations)
}

calculate_gap <- function(requested, allocated) {
  stopifnot(
    length(requested) == length(allocated),
    all(is.finite(requested)),
    all(is.finite(allocated))
  )

  requested - allocated
}

testthat::test_that(
  "allocation shares sum to one",
  {
    allocations <- c(
      Physics = 40,
      Biology = 35,
      Engineering = 25
    )

    shares <- calculate_shares(allocations)

    testthat::expect_equal(
      sum(shares),
      1
    )

    testthat::expect_equal(
      unname(shares),
      c(0.40, 0.35, 0.25)
    )
  }
)

testthat::test_that(
  "FoR demand totals equal overall demand",
  {
    # Illustrative 2030 demand reference
    total_demand <- 2502822

    shares <- c(
      Physics = 0.40,
      Biology = 0.35,
      Engineering = 0.25
    )

    demand <- allocate_demand(
      total_demand,
      shares
    )

    testthat::expect_equal(
      sum(demand),
      total_demand,
      tolerance = 1e-7
    )

    testthat::expect_equal(
      unname(demand),
      total_demand * c(0.40, 0.35, 0.25)
    )
  }
)

testthat::test_that(
  "equal shares produce equal allocations",
  {
    total_demand <- 900

    shares <- rep(1 / 9, 9)

    demand <- allocate_demand(
      total_demand,
      shares
    )

    testthat::expect_length(demand, 9)

    testthat::expect_equal(
      unname(demand),
      rep(100, 9)
    )

    testthat::expect_equal(
      sum(demand),
      900
    )
  }
)

testthat::test_that(
  "allocation gap equals requests minus allocations",
  {
    requested <- c(1000, 1200, 1500)
    allocated <- c(800, 900, 1000)

    gap <- calculate_gap(
      requested,
      allocated
    )

    testthat::expect_equal(
      gap,
      c(200, 300, 500)
    )
  }
)

testthat::test_that(
  "higher allocation reduces the request-allocation gap",
  {
    requested <- 2500

    allocation_levels <- c(
      low = 1000,
      medium = 1500,
      high = 2000
    )

    gaps <- calculate_gap(
      rep(requested, 3),
      allocation_levels
    )

    testthat::expect_equal(
      unname(gaps),
      c(1500, 1000, 500)
    )

    testthat::expect_true(
      all(diff(gaps) < 0)
    )
  }
)

testthat::test_that(
  "FoR shares are calculated from allocations, not demand",
  {
    # Illustrative historical allocation records
    allocations <- c(
      Group_A = 300,
      Group_B = 200,
      Group_C = 500
    )

    shares <- calculate_shares(
      allocations
    )

    testthat::expect_equal(
      unname(shares),
      c(0.3, 0.2, 0.5)
    )

    projected_demand <- allocate_demand(
      2000,
      shares
    )

    testthat::expect_equal(
      unname(projected_demand),
      c(600, 400, 1000)
    )
  }
)

testthat::test_that(
  "invalid shares are rejected",
  {
    testthat::expect_error(
      allocate_demand(
        1000,
        c(0.4, 0.4)
      )
    )

    testthat::expect_error(
      allocate_demand(
        1000,
        c(0.8, -0.1, 0.3)
      )
    )

    testthat::expect_error(
      allocate_demand(
        1000,
        c(0.5, NA_real_, 0.5)
      )
    )
  }
)

testthat::test_that(
  "scenario demand remains proportional to shares",
  {
    shares <- c(
      A = 0.2,
      B = 0.3,
      C = 0.5
    )

    first <- allocate_demand(
      1000,
      shares
    )

    second <- allocate_demand(
      2000,
      shares
    )

    testthat::expect_equal(
      second,
      2 * first
    )
  }
)
