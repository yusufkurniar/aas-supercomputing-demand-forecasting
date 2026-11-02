
# Verify published HPC projections using saved fitted models
# References:
# technical-analysis/07_model_development.qmd
# technical-analysis/10_scenario_forecasting.qmd

# Locate the model from the testthat working directory
model_path <- file.path(
  "..", "..",
  "assets", "models", "overall_hpc_models.rds"
)

testthat::test_that("overall HPC model file is available", {
  testthat::expect_true(
    file.exists(model_path)
  )
})

testthat::test_that("central HPC model reproduces 2030 forecast", {
  models <- readRDS(model_path)

  testthat::expect_s3_class(
    models$overall_linear,
    "lm"
  )

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

  # Published central forecast from Chapter 10:
  # 2,502,822 kSU, rounded to the nearest kSU

  testthat::expect_equal(
    forecast,
    2502822,
    tolerance = 1
  )
})

testthat::test_that("2026 sensitivity forecast is reproducible", {
  models <- readRDS(model_path)

  testthat::expect_s3_class(
    models$overall_linear_pre2026,
    "lm"
  )

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

  excluding_2026 <- as.numeric(
    predict(
      models$overall_linear_pre2026,
      newdata = future
    )
  )

  # Chapter 10 reports 2,285,327 kSU
  # when the 2026 observation is excluded.

  testthat::expect_equal(
    excluding_2026,
    2285327,
    tolerance = 1
  )

  testthat::expect_gt(
    central,
    excluding_2026
  )

  testthat::expect_equal(
    central - excluding_2026,
    217495,
    tolerance = 2
  )
})

testthat::test_that("central forecast covers 2027 to 2030", {
  models <- readRDS(model_path)

  future <- data.frame(
    year = 2027:2030,
    time = (2027:2030) - 2014
  )

  forecasts <- as.numeric(
    predict(
      models$overall_linear,
      newdata = future
    )
  )

  testthat::expect_length(forecasts, 4)

  testthat::expect_true(
    all(is.finite(forecasts))
  )

  testthat::expect_true(
    all(forecasts > 0)
  )

  testthat::expect_true(
    all(diff(forecasts) > 0)
  )
})

testthat::test_that("prediction intervals are correctly ordered", {
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
