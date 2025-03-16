# tdist-MCD
Code to reproduce the figures of paper "Robust distances and multivariate outlier detection under heavy tails"
# Robust distances and multivariate outlier detection under heavy tails

> **Note:** This repository contains code and instructions for replicating the results of a paper currently under peer review. Author information is intentionally omitted.

## Abstract

Heavy-tailed distributions, such as the Student-*t* distribution, have long been advocated as "robust" models for multivariate data in many fields. The underlying rationale is that robustness should be achieved by letting the classical maximum-likelihood estimators accommodate extreme observations naturally arising from the process under investigation. However, there is growing recognition that contamination might also occur under non-Gaussian scenarios. In this work we develop a unified approach which exploits high-breakdown estimation to ensure robust estimation of location, scatter and tail parameters under contamination of a multivariate Student-*t* distribution, when the latter is assumed to rule the data generating process of the uncontaminated part of the data. The framework that allows us to achieve our unified approach is the theory of generalized radius processes. In this framework, we first obtain the influence function of the main statistical functionals associated to robust Mahalanobis distances. We then suggest new statistics for measuring conformance to the multivariate Student-*t* distribution and an automatic procedure to infer the true values of the degrees of freedom and of the contamination rate. Along our path, we tackle several computational challenges associated to Monte Carlo estimation of the required radius-process quantiles and we provide extensive simulation evidence of the accuracy of our method.

## Contents

### Main Document
- [Figures (15)](#main-figures)
- [Tables (1)](#main-tables)

### Supplementary Information
- [Figures (7)](#si-figures)
- [Tables (2)](#si-tables)

## Replication Instructions

This repository contains code and data to replicate all figures and tables from both the main manuscript and the supplementary information document.

### Requirements

Code for replication uses the following dependencies:
- R version X.X.X or higher
- R packages: [list required packages]

### Setup

To prepare your environment for replication:
1. Clone this repository: `git clone https://github.com/username/reponame.git`
2. Navigate to the repository directory: `cd reponame`
3. Install required R packages: `Rscript install_packages.R`

## Main Document

This section provides instructions for reproducing all figures and tables from the main manuscript.

### Main Figures

#### Figure 1
Description of Figure 1

To reproduce: `Rscript code/figure1.R`

#### Figure 2
Description of Figure 2

To reproduce: `Rscript code/figure2.R`

<!-- Continue for all 15 figures -->
#### Figures 3-15
Description of remaining figures

To reproduce Figures 3-15: `Rscript code/figures_3_to_15.R`

### Main Tables

#### Table 1
Description of Table 1

To reproduce: `Rscript code/table1.R`

## Supplementary Information

This section provides instructions for reproducing all figures and tables from the supplementary information document.

### SI Figures

#### SI Figure 1
Description of SI Figure 1

To reproduce: `Rscript code/si_figure1.R`

<!-- Continue for all 7 SI figures -->
#### SI Figures 2-7
Description of remaining SI figures

To reproduce SI Figures 2-7: `Rscript code/si_figures_2_to_7.R`

### SI Tables

#### SI Table 1
Description of SI Table 1

To reproduce: `Rscript code/si_table1.R`

#### SI Table 2
Description of SI Table 2

To reproduce: `Rscript code/si_table2.R`

## Additional Information

For questions or issues regarding the replication code, please open an issue in this repository.

> Author information and additional acknowledgments will be added after the peer review process is complete.