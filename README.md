# Forecasting Demand for National Research Supercomputing

**Australian Academy of Science \| HPC Demand Forecasting to 2030**

**Author:** Yusuf Kurnia Romadhon\
**Program:** Master of Business Analytics, Monash University\
**Project:** Industry internship, 2026

## Project Overview

This project examines historical demand for Australian national research high-performance computing (HPC) resources and develops demand projections through 2030.

The analysis uses publicly available records from the National Computational Infrastructure (NCI), Pawsey Supercomputing Research Centre and National Computational Merit Allocation Scheme (NCMAS).

The project covers data collection and integration, resource conversion, forecasting model evaluation, and scenario analysis. It also examines historical allocation patterns and the distribution of computing resources across Fields of Research (FoR).

## Individual Contributions

My work focused on preparing historical Australian research computing data and developing forecasts of HPC demand through 2030. The main contributions were:

-   **Data integration:** Compiled historical demand, allocation and Field of Research (FoR) records from NCI, Pawsey and NCMAS publications into consistent annual datasets.
-   **Data preparation:** Reconciled reporting periods, computing systems, measurement units and resource definitions. Documented the original values, conversion assumptions and reconstructed observations.
-   **Forecasting:** Developed and evaluated naïve, drift, linear trend and log-linear trend models for overall HPC, CPU and GPU demand using rolling-origin cross-validation.
-   **Scenario analysis:** Examined the effects of alternative growth assumptions, historical FoR allocation shares and illustrative future allocation levels.
-   **Reporting and reproducibility:** Prepared the final report, technical Quarto analysis, visualisations, intermediate datasets and supporting documentation.

The original source publications were produced by their respective organisations. The integration, conversions, forecasting analysis and interpretation were undertaken for this internship project.

## Project Deliverables

| Output | Link |
|------------------------------------|------------------------------------|
| **Final report (HTML): main deliverable** | [**Read the final report online**](https://yusufkurniar.github.io/aas-supercomputing-demand-forecasting/) |
| **Final report (PDF)** | [Download the report](docs/report.pdf) |
| Project presentation (PDF) | [Download PDF](presentation/presentation.pdf) |
| Detailed technical analysis | [View Quarto source](technical-analysis/index.qmd) |

**Start with the final report.** It presents the findings, projections to 2030, limitations, and planning implications. The technical analysis, datasets, and saved models are supporting materials for readers who want to inspect or reproduce the work. The final report is published through GitHub Pages.

## Key Findings

-   Recorded HPC requests reached approximately **2.24 million kSU in 2026**, compared with allocations of approximately **872,000 kSU**.
-   The selected linear trend model projects approximately **2.50 million kSU** of recorded HPC requests by 2030.
-   The central CPU projection reaches approximately **1.37 billion core-hours** by 2030.
-   GPU projections remain exploratory because of the limited historical data.
-   FoR scenarios show how different historical allocation patterns affect the distribution of projected HPC demand.
-   Allocation sensitivity scenarios illustrate how different allocation levels affect the gap between projected requests and allocations.

These results provide a reference for planning discussions. They should not be interpreted as direct estimates of physical infrastructure requirements or total unmet national research demand.

## Datasets

The repository contains original, cleaned, standardised and converted datasets used throughout the analysis.

### Standardised Datasets

| Dataset | Description | Download |
|------------------------|------------------------|------------------------|
| `annual_demand_allocation.rds` | Standardised annual demand and allocation records | [Download](assets/data/data%20standardised/annual_demand_allocation.rds) |
| `field_of_research.rds` | Standardised FoR allocation records | [Download](assets/data/data%20standardised/field_of_research.rds) |

### Converted Datasets

| Dataset | Description | Download |
|------------------------|------------------------|------------------------|
| `annual_demand_allocation_converted.rds` | Annual computing resource data after the documented conversions | [Download](assets/data/data%20converted/annual_demand_allocation_converted.rds) |
| `field_of_research_converted.rds` | FoR data prepared for the subsequent analysis | [Download](assets/data/data%20converted/field_of_research_converted.rds) |

The `.rds` files can be loaded in R using `readRDS()`.

For example:

``` r
hpc_data <- readRDS(
  "assets/data/data standardised/annual_demand_allocation.rds"
)
```

The datasets were compiled and processed for this project. They are not official consolidated national HPC demand datasets.

## Data Sources and Conversion Documentation

The following workbooks provide supporting information on the original records, data integration and conversion process.

| Workbook | Purpose |
|------------------------------------|------------------------------------|
| [Integrated HPC Source Data](assets/data/data%20clean/integrated_hpc_source_data.xlsx) | Historical source data integration |
| [Yearly Conversion](assets/progress/Yearly%20Conversion.xlsx) | Year-by-year resource conversion calculations |
| [Reconciled Demand and Allocation Summary](assets/data/data%20clean/reconciled_demand_allocation_summary.xlsx) | Reconciliation of annual demand and allocation records |
| [Reconciled FoR Summary](assets/data/data%20clean/reconciled_field_of_research_summary.xlsx) | Reconciliation of historical FoR records |

Original source workbooks are retained under `assets/data/raw data/`.

The technical documentation explains the assumptions, measurement units and classification changes involved in preparing the analytical datasets.

## Repository Structure

``` text
aas-supercomputing-demand-forecasting/
├── assets/
│   ├── data/
│   │   ├── raw data/
│   │   │   ├── demand and allocation/
│   │   │   ├── field of research/
│   │   │   └── supporting data/
│   │   ├── data clean/
│   │   ├── data standardised/
│   │   └── data converted/
│   ├── models/
│   │   ├── cpu_models.rds
│   │   ├── gpu_models.rds
│   │   └── overall_hpc_models.rds
│   └── progress/
│       ├── Internship Progress.xlsx
│       └── Yearly Conversion.xlsx
├── report/
│   ├── report.qmd
│   └── styles.css
├── presentation/
│   └── presentation.pdf
├── technical-analysis/
│   ├── _quarto.yml
│   ├── index.qmd
│   ├── 01_data_collection.qmd
│   ├── ...
│   └── 11_references_acknowledgement.qmd
├── docs/                         # GitHub Pages output
│   ├── index.html
│   ├── report.pdf
│   └── presentation.pdf
├── renv/
│   ├── activate.R
│   └── settings.json
├── renv.lock                     # Locked R dependencies
├── .Rprofile                     # Activates renv when R starts
├── _quarto.yml                   # Root Quarto configuration
├── sync-docs.R                   # Post-render publishing script
├── references.bib
├── .gitignore
├── LICENSE                       # MIT License for original project code
├── aas-supercomputing-demand-forecasting.Rproj
└── README.md
```

The `renv/library/` directory contains locally installed packages and is not committed to Git. GitHub Pages is served from `docs/`; generated files under `docs/report/` may also be present after rendering.

### Folder Descriptions

**`assets/data/`**

The data folders follow the preparation stages used in the technical analysis:

| Folder | Contents and purpose |
|------------------------------------|------------------------------------|
| `raw data/demand and allocation/` | Thirteen annual source workbooks (2013/14–2025/26) containing historical HPC demand and allocation records. |
| `raw data/field of research/` | Thirteen annual source workbooks (2014–2026) containing Field of Research (FoR) information. |
| `raw data/supporting data/` | Contains three supplementary working datasets: `demand_allocation_all_years_v2.xlsx`, `ncmas_data.xlsx`, and `yearly_field_of_research_data.xlsx`. These files are retained as supporting project records and are not identified as direct inputs in the documented technical-analysis workflow. |
| `data clean/` | Cleaned and reconciled workbooks used during data integration and standardisation, including `demand_allocation_data.xlsx`, `integrated_hpc_source_data.xlsx`, `reconciled_demand_allocation_summary.xlsx`, and `reconciled_field_of_research_summary.xlsx`. |
| `data standardised/` | Two RDS datasets, `annual_demand_allocation.rds` and `field_of_research.rds`, containing standardised annual records. |
| `data converted/` | Five RDS datasets containing converted computing measures, harmonised FoR shares, and historical GPU scenarios for subsequent analysis. |

The raw source files are retained to make it possible to trace processed values back to the underlying records. The cleaned, standardised, and converted files represent successive stages of the analysis; they should not be treated as interchangeable.

**`assets/models/`**

Contains saved R forecasting model objects for overall HPC demand, CPU, and GPU analyses: `overall_hpc_models.rds`, `cpu_models.rds`, and `gpu_models.rds`. These can be inspected without refitting every model.

**`assets/progress/`**

Contains two supporting workbooks:

-   `Internship Progress.xlsx`: Internship progress tracking and project documentation.
-   `Yearly Conversion.xlsx`: Year-by-year resource conversion calculations supporting the data preparation and conversion assumptions.

**`report/`**

Contains the final internship report source and styling. Published HTML and PDF versions are available under `docs/`.

**`presentation/`**

Contains the project presentation PDF, presentation source files, and supporting theme resources.

**`technical-analysis/`**

Contains the detailed Quarto book documenting the analytical workflow. Its chapters cover data collection, variable definitions, data integration, data standardisation, resource conversion, initial analysis, model development, model evaluation, model selection, scenario forecasting, and references. This material provides additional technical detail beyond the final internship report.

**`references.bib`**

Contains bibliography records used by the Quarto documents.

## Reproducibility and Technical Analysis

The repository contains the Quarto source, intermediate datasets, saved R models, and a versioned R package environment. Three examples were tested successfully after clearing the R workspace in the development environment. The complete technical Quarto book was rendered successfully in the configured R 4.5.3 environment on 2 November 2026. Reproduction on a separate, freshly configured computer has **not yet been verified**.

### Software and R Packages

The project was developed using **R 4.5.3** and Quarto. R package versions are recorded in `renv.lock`, and the repository includes the `renv` activation files. You do **not** need to download or commit an R package library: `renv` restores the dependencies on each user's computer.

Install [R](https://cran.r-project.org/), [Quarto](https://quarto.org/docs/get-started/), and optionally [RStudio](https://posit.co/download/rstudio-desktop/). RStudio is recommended for opening the project.

### Get Started

Clone the repository:

``` bash
git clone https://github.com/yusufkurniar/aas-supercomputing-demand-forecasting.git
cd aas-supercomputing-demand-forecasting
```

Open `aas-supercomputing-demand-forecasting.Rproj` in RStudio. The GitHub URL above reflects the current repository owner; update it if the repository is transferred.

From the **repository root**, restore the recorded packages in the R Console:

``` r
# Install renv if it is not available
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")

# Restore the package versions recorded in renv.lock
renv::restore()

# Check the project environment
renv::status()
```

Restoring packages requires an internet connection and can take several minutes. Some packages may need additional system dependencies, depending on the operating system. The lockfile records the development environment, but a fresh-machine restoration has not yet been verified.

**Do not commit `renv/library/`.** That directory is machine-specific; the files `renv.lock`, `renv/activate.R`, `renv/settings.json`, and `.Rprofile` are the reproducibility configuration that belongs in version control.

### Example 1: Load and Inspect the Prepared Annual Dataset

Run from the repository root in R:

``` r
annual <- readRDS(
  "assets/data/data standardised/annual_demand_allocation.rds"
)

names(annual)
head(annual)
summary(annual)
```

This example loads the prepared annual data without re-running the earlier data-cleaning steps.

### Example 2: Inspect Historical Demand and Allocation Records

The standardised annual dataset contains historical demand and allocation records before all resource conversions have been applied. The following example checks the available variables, reporting years and missing values.

``` r
annual <- readRDS(
  "assets/data/data standardised/annual_demand_allocation.rds"
)

# Inspect the dataset structure
str(annual)

# Check reporting years
sort(unique(annual$year))

# Check the completeness of key variables
key_vars <- c(
  "year",
  "requested_compute",
  "allocated_compute"
)

stopifnot(all(key_vars %in% names(annual)))

colSums(is.na(annual[key_vars]))

# Inspect the recorded values
head(annual[key_vars])
```

Historical reporting units and resource definitions differ across computing systems and periods. The standardised dataset is therefore intended for inspecting the recorded information, rather than directly comparing demand trends across all years. The converted datasets and the resource conversion methodology in Chapter 05 of the technical analysis should be used for harmonised comparisons.

### Example 3: Inspect a Saved Model Object

``` r
models <- readRDS(
  "assets/models/overall_hpc_models.rds"
)

class(models)
names(models)
str(models, max.level = 1)
```

The model objects are provided for inspection. See Chapters 07–10 for model specifications, evaluation, selection, and forecasting scenarios.

### Reproduce the Technical Analysis (Supporting Material)

The final report is the main project deliverable. The technical Quarto book provides supporting code and detailed documentation for assessing reproducibility. After restoring the packages, run this command from the repository root:

``` bash
quarto render technical-analysis --to html
```

This command was successfully tested on 2 November 2026 using R 4.5.3 on Windows. It processed the book index and all 11 technical chapters, generating `technical-analysis/_book/index.html`. This verifies rendering in the configured development environment, not a fresh-machine rebuild. Rendering may regenerate datasets and saved model files.

### Technical Workflow and Execution Order

The Quarto book is organised in the following sequence:

| Stage | Source | Purpose |
|------------------------|------------------------|------------------------|
| 1 | `01_data_collection.qmd` | Identify and document source records |
| 2 | `02_variable_definition.qmd` | Define analytical variables |
| 3 | `03_data_integration.qmd` | Integrate and reconcile historical records |
| 4 | `04_data_standardisation.qmd` | Standardise periods, fields, and datasets |
| 5 | `05_data_conversion.qmd` | Document and apply resource conversions |
| 6 | `06_initial_analysis.qmd` | Explore historical patterns |
| 7 | `07_model_development.qmd` | Fit and save forecasting models |
| 8 | `08_model_evaluation.qmd` | Evaluate model performance |
| 9 | `09_model_selection.qmd` | Select reference specifications |
| 10 | `10_scenario_forecasting.qmd` | Produce 2027–2030 scenarios |
| 11 | `11_references_acknowledgement.qmd` | References and acknowledgements |

**Dependencies between stages:** Chapter 05 reads the standardised RDS files created in Chapter 04. Later chapters use converted datasets and saved model objects, including models written in Chapter 07. Run the chapters in order when regenerating intermediate outputs. Existing processed datasets and models are included for inspection without rebuilding everything.

### Render the Final Report (Main Deliverable)

The published HTML and PDF links above are the easiest way to read the report. To regenerate them locally, run from the repository root:

``` bash
quarto render report/report.qmd --to html
```

The root `_quarto.yml` currently sends project output to `docs/` and invokes `sync-docs.R` after rendering. This updates the local published HTML homepage at `docs/index.html`. To publish changes to GitHub Pages, commit and push the changed files.

For the PDF, render separately:

``` bash
quarto render report/report.qmd --to pdf
```

The post-render script copies `docs/report/report.pdf` to `docs/report.pdf` **if that generated file exists**. Verify the PDF's modification date after rendering.

### Reproducibility Scope

-   **Provided:** Quarto source chapters, cleaned and processed datasets, saved model objects, conversion documentation, and report outputs.
-   **Verified locally:** All 11 technical chapters rendered successfully on 2 November 2026 using the configured R 4.5.3 environment. **Still to verify:** Restoration and end-to-end execution on another computer or a clean installation. Package versions are recorded in `renv.lock`.
-   **Data provenance:** Source workbooks, reconciliation summaries, and conversion assumptions are documented in the repository and technical chapters.
-   **Important:** The dataset files were assembled for this project; they are not an official, consolidated national HPC demand dataset.

## Limitations

The historical records differ in reporting periods, computing systems, measurement units and resource definitions. Some observations required reconstruction or conversion.

The forecasting models were developed using limited annual observations, and the projections depend on the assumed growth patterns.

Historical allocation shares and request–allocation gaps should not be interpreted as direct measures of total research demand or future infrastructure capacity requirements.

Further details are provided in the final report and technical documentation.

## Data Attribution

The analysis draws on publicly available information from:

-   National Computational Infrastructure (NCI)
-   Pawsey Supercomputing Research Centre
-   National Computational Merit Allocation Scheme (NCMAS)
-   Australian Bureau of Statistics (ABS), for Field of Research classification documentation

Individual publications and sources are acknowledged in the report bibliography.

## Licence

The original code developed for this project is available under the MIT License. See [LICENSE](LICENSE).

The underlying datasets and third-party materials remain subject to their original sources' terms and conditions. The MIT License does not grant additional rights to those materials.

## Acknowledgement

This project was undertaken as part of the Master of Business Analytics internship at Monash University, in collaboration with the Australian Academy of Science.
