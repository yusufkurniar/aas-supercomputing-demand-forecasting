
# Automated tests for HPC demand forecasting
# Run from the repository root:
# source("tests/run_tests.R")

if (!requireNamespace("testthat", quietly = TRUE)) {
  stop("Please install testthat first.")
}

# Confirm the repository root
stopifnot(
  file.exists("renv.lock"),
  dir.exists("technical-analysis"),
  dir.exists("tests/testthat")
)

# Find test files
test_files <- list.files(
  "tests/testthat",
  pattern = "^test-.*[.]R$",
  full.names = TRUE
)

cat("Test files found:\n")
print(test_files)

if (length(test_files) == 0) {
  stop("No test files found in tests/testthat.")
}

# Run tests from the repository root so relative data paths work
for (test_file in test_files) {
  cat("\nRunning:", test_file, "\n")

  testthat::test_file(
    test_file,
    reporter = "summary",
    stop_on_failure = TRUE
  )
}

cat("\nAll test files completed.\n")
