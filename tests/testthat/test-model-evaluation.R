
# Model evaluation reference tests
# References:
# technical-analysis/08_model_evaluation.qmd
# report/report.qmd, Section 3.4
#
# These tests use synthetic data to check the documented
# expanding-window evaluation method and accuracy formulas.

make_folds <- function(years, initial_end) {
  stopifnot(
    length(years) > 0,
    !anyNA(years),
    !anyDuplicated(years),
    identical(years, sort(years)),
    initial_end %in% years
  )

  test_years <- years[years > initial_end]

  lapply(test_years, function(test_year) {
    list(
      train = years[years < test_year],
      test = test_year
    )
  })
}

calculate_accuracy <- function(actual, predicted) {
  stopifnot(
    is.numeric(actual),
    is.numeric(predicted),
    length(actual) == length(predicted),
    length(actual) > 0,
    all(is.finite(actual)),
    all(is.finite(predicted))
  )

  errors <- actual - predicted

  c(
    RMSE = sqrt(mean(errors^2)),
    MAE = mean(abs(errors))
  )
}

testthat::test_that(
  "HPC and CPU evaluation covers 2021 to 2026",
  {
    folds <- make_folds(
      years = 2014:2026,
      initial_end = 2020
    )

    test_years <- vapply(
      folds, function(x) x$test, integer(1)
    )

    testthat::expect_length(folds, 6)
    testthat::expect_equal(test_years, 2021:2026)

    testthat::expect_equal(
      folds[[1]]$train,
      2014:2020
    )

    testthat::expect_equal(
      folds[[6]]$train,
      2014:2025
    )
  }
)

testthat::test_that(
  "GPU evaluation covers 2025 and 2026",
  {
    folds <- make_folds(
      years = 2022:2026,
      initial_end = 2024
    )

    test_years <- vapply(
      folds, function(x) x$test, integer(1)
    )

    testthat::expect_length(folds, 2)
    testthat::expect_equal(
      test_years,
      2025:2026
    )

    testthat::expect_equal(
      folds[[1]]$train,
      2022:2024
    )

    testthat::expect_equal(
      folds[[2]]$train,
      2022:2025
    )
  }
)

testthat::test_that(
  "training data never includes the test year",
  {
    for (years in list(2014:2026, 2022:2026)) {
      initial_end <- if (min(years) == 2014) {
        2020
      } else {
        2024
      }

      folds <- make_folds(years, initial_end)

      for (fold in folds) {
        testthat::expect_true(
          all(fold$train < fold$test)
        )

        testthat::expect_false(
          fold$test %in% fold$train
        )

        testthat::expect_equal(
          max(fold$train) + 1,
          fold$test
        )
      }
    }
  }
)

testthat::test_that(
  "training window expands by one year",
  {
    folds <- make_folds(2014:2026, 2020)

    sizes <- vapply(
      folds,
      function(x) length(x$train),
      integer(1)
    )

    testthat::expect_equal(
      sizes,
      7:12
    )

    testthat::expect_true(
      all(diff(sizes) == 1)
    )
  }
)

testthat::test_that(
  "RMSE and MAE match independently calculated values",
  {
    actual <- c(10, 20, 30)
    predicted <- c(12, 18, 27)

    accuracy <- calculate_accuracy(
      actual,
      predicted
    )

    testthat::expect_equal(
      unname(accuracy["RMSE"]),
      sqrt(17 / 3)
    )

    testthat::expect_equal(
      unname(accuracy["MAE"]),
      7 / 3
    )

    testthat::expect_gte(
      unname(accuracy["RMSE"]),
      unname(accuracy["MAE"])
    )
  }
)

testthat::test_that(
  "perfect predictions have zero error",
  {
    values <- c(100, 200, 300)

    accuracy <- calculate_accuracy(
      values,
      values
    )

    testthat::expect_equal(
      unname(accuracy),
      c(0, 0)
    )
  }
)

testthat::test_that(
  "one-step-ahead linear forecasts use past observations",
  {
    # Synthetic series with an exact linear trend.
    sample_data <- data.frame(
      year = 2014:2026
    )

    sample_data$demand <- (
      100 + 20 * (sample_data$year - 2014)
    )

    folds <- make_folds(
      sample_data$year,
      initial_end = 2020
    )

    predictions <- vapply(
      folds,
      function(fold) {
        training <- sample_data[
          sample_data$year %in% fold$train,
          ,
          drop = FALSE
        ]

        model <- lm(
          demand ~ year,
          data = training
        )

        as.numeric(
          predict(
            model,
            newdata = data.frame(
              year = fold$test
            )
          )
        )
      },
      numeric(1)
    )

    actual <- sample_data$demand[
      sample_data$year %in% 2021:2026
    ]

    accuracy <- calculate_accuracy(
      actual,
      predictions
    )

    testthat::expect_equal(
      predictions,
      as.numeric(actual),
      tolerance = 1e-7
    )

    testthat::expect_equal(
      unname(accuracy),
      c(0, 0),
      tolerance = 1e-7
    )
  }
)

testthat::test_that(
  "invalid accuracy inputs are rejected",
  {
    testthat::expect_error(
      calculate_accuracy(
        c(1, 2, 3),
        c(1, 2)
      )
    )

    testthat::expect_error(
      calculate_accuracy(
        c(1, NA, 3),
        c(1, 2, 3)
      )
    )
  }
)
