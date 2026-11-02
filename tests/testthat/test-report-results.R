
# Automated checks for the main HPC forecasting report
#
# References:
# report/report.qmd
# technical-analysis/07_model_development.qmd
# technical-analysis/10_scenario_forecasting.qmd
#
# Run using:
# source("tests/run_tests.R")
#
# These tests verify report inputs and numerical reference
# results. They do not replace academic proofreading or
# verify every statement in the rendered report.

# testthat executes test files from tests/testthat/
root <- file.path("..", "..")

report_path <- file.path(root, "report", "report.qmd")

model_path <- file.path(
  root, "assets", "models", "overall_hpc_models.rds"
)

testthat::test_that("main report source is available", {

  testthat::expect_true(file.exists(report_path))

  report <- readLines(
    report_path,
    warn = FALSE,
    encoding = "UTF-8"
  )

  testthat::expect_gt(length(report), 0)

  testthat::expect_true(
    any(grepl("^---\\s*$", report))
  )
})

testthat::test_that("report and model files are readable", {

  testthat::expect_true(file.exists(report_path))
  testthat::expect_true(file.exists(model_path))

  models <- readRDS(model_path)

  testthat::expect_true(is.list(models))

  testthat::expect_true(
    "overall_linear" %in% names(models)
  )
})

testthat::test_that("2030 central HPC forecast matches report reference", {

  models <- readRDS(model_path)

  future <- data.frame(
    year = 2030,
    time = 2030 - 2014
  )

  forecast <- as.numeric(
    predict(
      models$overall_linear,
      newdata = future
    )
  )

  # Reference result: 2,502,822 kSU
  testthat::expect_equal(
    round(forecast),
    2502822
  )
})

testthat::test_that("2030 sensitivity result matches report reference", {

  models <- readRDS(model_path)

  future <- data.frame(
    year = 2030,
    time = 2030 - 2014
  )

  central <- as.numeric(
    predict(
      models$overall_linear,
      newdata = future
    )
  )

  sensitivity <- as.numeric(
    predict(
      models$overall_linear_pre2026,
      newdata = future
    )
  )

  testthat::expect_equal(
    round(sensitivity),
    2285327
  )

  testthat::expect_gt(
    central,
    sensitivity
  )

  testthat::expect_equal(
    round(central) - round(sensitivity),
    217495
  )
})

testthat::test_that("forecast horizon is 2027 to 2030", {

  models <- readRDS(model_path)

  years <- 2027:2030

  future <- data.frame(
    year = years,
    time = years - 2014
  )

  forecasts <- as.numeric(
    predict(
      models$overall_linear,
      newdata = future
    )
  )

  testthat::expect_equal(
    years,
    c(2027L, 2028L, 2029L, 2030L)
  )

  testthat::expect_length(forecasts, 4)

  testthat::expect_true(
    all(is.finite(forecasts))
  )

  testthat::expect_true(
    all(forecasts > 0)
  )
})

testthat::test_that("central forecast is within prediction intervals", {

  models <- readRDS(model_path)

  future <- data.frame(
    year = 2027:2030,
    time = (2027:2030) - 2014
  )

  pi80 <- predict(
    models$overall_linear,
    newdata = future,
    interval = "prediction",
    level = 0.80
  )

  pi95 <- predict(
    models$overall_linear,
    newdata = future,
    interval = "prediction",
    level = 0.95
  )

  testthat::expect_true(
    all(pi95[, "lwr"] <= pi80[, "lwr"])
  )

  testthat::expect_true(
    all(pi80[, "lwr"] <= pi80[, "fit"])
  )

  testthat::expect_true(
    all(pi80[, "fit"] <= pi80[, "upr"])
  )

  testthat::expect_true(
    all(pi80[, "upr"] <= pi95[, "upr"])
  )
})
