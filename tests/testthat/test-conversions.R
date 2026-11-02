
# Tests for documented HPC resource conversion rules
# Reference: technical-analysis/05_data_conversion.qmd

testthat::test_that("kSU converts to service units correctly", {
  ksu <- c(0, 1, 100, 2500)

  su <- ksu * 1000

  testthat::expect_equal(
    su,
    c(0, 1000, 100000, 2500000)
  )
})

testthat::test_that("CPU conversions respect system-specific factors", {
  # 2026 values documented in Chapter 05
  gadi_ksu <- 387288
  setonix_cpu_ksu <- 325000

  # Gadi: 2 SU per CPU core-hour
  gadi_hours <- gadi_ksu * 1000 / 2

  # Setonix CPU: 1 SU per CPU core-hour
  setonix_hours <- setonix_cpu_ksu * 1000 / 1

  testthat::expect_equal(gadi_hours, 193644000)
  testthat::expect_equal(setonix_hours, 325000000)

  testthat::expect_equal(
    gadi_hours + setonix_hours,
    518644000
  )
})

testthat::test_that("historical million-hour conversion is correct", {
  # Historical working assumption:
  # 1 service unit per CPU core-hour

  million_hours <- c(1, 2.5, 10)

  calculated_ksu <- million_hours * 1000

  testthat::expect_equal(
    calculated_ksu,
    c(1000, 2500, 10000)
  )
})

testthat::test_that("conversion preserves missing observations", {
  values <- c(100, NA_real_, 250)
  converted <- values * 1000

  testthat::expect_true(is.na(converted[2]))
  testthat::expect_equal(
    converted[c(1, 3)],
    c(100000, 250000)
  )
})
