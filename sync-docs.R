file.copy(
  "docs/report/index.html",
  "docs/index.html",
  overwrite = TRUE
)

if (file.exists("docs/report/report.pdf")) {
  file.copy(
    "docs/report/report.pdf",
    "docs/report.pdf",
    overwrite = TRUE
  )
}