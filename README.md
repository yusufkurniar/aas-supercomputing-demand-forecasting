# Forecasting Demand for National Research Supercomputing

**Australian Academy of Science \| HPC Demand Forecasting to 2030**

**Author:** Yusuf Kurnia Romadhon\
**Program:** Master of Business Analytics, Monash University\
**Project:** Industry internship, 2026

## Project Overview

This project examines historical demand for Australian national research high-performance computing (HPC) resources and develops demand projections through 2030.

The analysis uses publicly available records from the National Computational Infrastructure (NCI), Pawsey Supercomputing Research Centre and National Computational Merit Allocation Scheme (NCMAS).

The project covers data collection and integration, resource conversion, forecasting model evaluation, and scenario analysis. It also examines historical allocation patterns and the distribution of computing resources across Fields of Research (FoR).

## Project Outputs

| Output | Link |
|---|---|
| Final report (HTML) | [Read online](https://yusufkurniar01.github.io/aas-supercomputing-demand-forecasting/) |
| Final report (PDF) | [Download PDF](report/report.pdf) |
| Project presentation (PDF) | [Download PDF](presentation/presentation.pdf) |
| Detailed technical analysis | [View Quarto source](technical-analysis/index.qmd) |

The technical analysis will also be available as a GitHub Pages website once publishing is configured.

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
|
|-- assets/
|   |-- data/
|   |   |-- raw data/
|   |   |-- data clean/
|   |   |-- data standardised/
|   |   `-- data converted/
|   |-- models/
|   `-- progress/
|
|-- report/
|   |-- report.qmd
|   |-- report.pdf
|   |-- report.html
|   `-- styles.css
|
|-- presentation/
|   |-- presentation.pdf
|   `-- [presentation source and theme files]
|
|-- technical-analysis/
|   |-- _quarto.yml
|   |-- index.qmd
|   |-- 01_data_collection.qmd
|   |-- ...
|   `-- 11_references_acknowledgement.qmd
|
|-- references.bib
|-- .gitignore
|-- aas-supercomputing-demand-forecasting.Rproj
`-- README.md
```

### Folder Descriptions

**`report/`**

Contains the final internship report in PDF and HTML formats, its Quarto source file and associated styling. This is the main report submitted for assessment.

**`presentation/`**

Contains the project presentation PDF, presentation source files and supporting theme resources.

**`technical-analysis/`**

Contains the detailed Quarto book documenting the analytical workflow. Its chapters cover:

1.  Data collection
2.  Variable definitions
3.  Data integration
4.  Data standardisation
5.  Resource conversion
6.  Initial analysis
7.  Model development
8.  Model evaluation
9.  Model selection
10. Scenario forecasting
11. References and acknowledgements

This material provides additional technical detail beyond the final internship report.

**`assets/data/`**

Contains the datasets used in the project:

-   `raw data/`: Original source workbooks and historical records.
-   `data clean/`: Integrated, cleaned and reconciled records.
-   `data standardised/`: Standardised datasets.
-   `data converted/`: Converted datasets prepared for analysis.

**`assets/models/`**

Contains saved R model objects used in forecasting and scenario analysis.

**`assets/progress/`**

Contains supporting workbooks and working materials produced during the internship. These materials are retained for project documentation and review.

**`references.bib`**

Contains bibliography records used by the Quarto documents.

## Reproducing the Analysis

The analysis was developed using R and Quarto.

### Requirements

-   R
-   Quarto
-   R packages referenced in the Quarto source files

### Steps

1.  Clone or download this repository.
2.  Open `aas-supercomputing-demand-forecasting.Rproj` in RStudio.
3.  Install the R packages required by the technical chapters.
4.  Confirm the datasets and model files are available under `assets/`.
5.  Render the technical analysis from the repository root:

``` bash
quarto render technical-analysis --to html
```

Alternatively, open a terminal inside `technical-analysis/` and run:

``` bash
quarto render --to html
```

The rendered technical book is generated in `technical-analysis/_book/` under the current configuration.

To render the final report separately:

``` bash
quarto render report/report.qmd
```

The source files and documented assumptions are provided to support review, reproduction and future updates.

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

## Acknowledgement

This project was undertaken as part of the Master of Business Analytics internship at Monash University, in collaboration with the Australian Academy of Science.
