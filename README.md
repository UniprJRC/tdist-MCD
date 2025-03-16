# tdist-MCD
Code to reproduce the figures of paper "Robust distances and multivariate outlier detection under heavy tails"
# Robust distances and multivariate outlier detection under heavy tails

> **Note:** This repository contains code and instructions for replicating the results of a paper currently under peer review. Author information is intentionally omitted.

## Abstract

Heavy-tailed distributions, such as the Student-*t* distribution, have long been advocated as "robust" models for multivariate data in many fields. The underlying rationale is that robustness should be achieved by letting the classical maximum-likelihood estimators accommodate extreme observations naturally arising from the process under investigation. However, there is growing recognition that contamination might also occur under non-Gaussian scenarios. In this work we develop a unified approach which exploits high-breakdown estimation to ensure robust estimation of location, scatter and tail parameters under contamination of a multivariate Student-*t* distribution, when the latter is assumed to rule the data generating process of the uncontaminated part of the data. The framework that allows us to achieve our unified approach is the theory of generalized radius processes. In this framework, we first obtain the influence function of the main statistical functionals associated to robust Mahalanobis distances. We then suggest new statistics for measuring conformance to the multivariate Student-*t* distribution and an automatic procedure to infer the true values of the degrees of freedom and of the contamination rate. Along our path, we tackle several computational challenges associated to Monte Carlo estimation of the required radius-process quantiles and we provide extensive simulation evidence of the accuracy of our method.

## Contents

### Main Document
- [Code Files](#main-document-code-files)
- [Replication Instructions](#replication-instructions)

### Supplementary Information
- [Code Files](#supplementary-information-code-files)

## Replication Instructions

This repository contains code and data to replicate all figures and tables from both the main manuscript and the supplementary information document.

### Requirements

Code for replication uses the following dependencies:
- MATLAB license or the license-free MATLAB online (https://it.mathworks.com/products/matlab-online.html)
- FSDA toolbox for MATLAB
- R version X.X.X or higher
- R packages: [list required packages]

### Setup

To prepare your environment for replication:
1. Clone this repository: `git clone https://github.com/username/reponame.git`
2. Navigate to the repository directory: `cd reponame`
3. Install required R packages: `Rscript install_packages.R`
4. Install FSDA from "Install App" of the standard MATLAB distribution or go to https://it.mathworks.com/matlabcentral/fileexchange/72999-fsda-flexible-statistics-data-analysis-toolbox. FSDA requires the Statistical and Machine Learning Toolbox. The parallel processing Toolbox is necessary if the reader needs to replicate the estimates, which take lot of time otherwise.

## Main Document Code Files

In the table below you can find the original source (MATLAB live script): .mlx file and the corresponding .ipynb file.

### MATLAB live script files

The .mlx files contain both the code and the output that the code produces.

👀 To view the .mlx files click on the "File Exchange button"

▶️ To run the .mlx files in the free MATLAB on line click on "Run in MATLAB Online". The repo will be automatically cloned.

The Jupyter notebook version of the files is also given in the last column of the table below. Similarly to the .mlx files the Jupyter notebook files also contain both the code and the output produced by the code.

### Jupiter notebook files

To view the .ipynb files click on the corresponding link.

To run the .ipynb files inside the agnostic environment jupyter notebook follow the instructions in the file ipynbRunInstructions.md.

| FileName | View 👀 | Run ▶️ | Jupiter notebook |
|----------|---------|--------|-----------------|
| Figure1.mlx : generate Figure 1 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure1.ipynb](Figure1.ipynb) |
| Figure2.mlx : generate Figure 2 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure2.ipynb](Figure2.ipynb) |
| Figure3.mlx : generate Figure 3 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure3.ipynb](Figure3.ipynb) |
| Figure4.mlx : generate Figure 4 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure4.ipynb](Figure4.ipynb) |
| Figure5.mlx : generate Figure 5 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure5.ipynb](Figure5.ipynb) |
| Figure6.mlx : generate Figure 6 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure6.ipynb](Figure6.ipynb) |
| Figure7.mlx : generate Figure 7 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure7.ipynb](Figure7.ipynb) |
| Figure8.mlx : generate Figure 8 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure8.ipynb](Figure8.ipynb) |
| Figure9.mlx : generate Figure 9 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure9.ipynb](Figure9.ipynb) |
| Figure10.mlx : generate Figure 10 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure10.ipynb](Figure10.ipynb) |
| Figure11.mlx : generate Figure 11 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure11.ipynb](Figure11.ipynb) |
| Figure12.mlx : generate Figure 12 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure12.ipynb](Figure12.ipynb) |
| Figure13.mlx : generate Figure 13 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure13.ipynb](Figure13.ipynb) |
| Figure14.mlx : generate Figure 14 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure14.ipynb](Figure14.ipynb) |
| Figure15.mlx : generate Figure 15 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Figure15.ipynb](Figure15.ipynb) |
| Table1.mlx : generate Table 1 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [Table1.ipynb](Table1.ipynb) |

Remark: in order to run the files we assume that the free MATLAB Add On FSDA must be installed.

## Supplementary Information Code Files

In the table below you can find the original source (MATLAB live script): .mlx file and the corresponding .ipynb file for the supplementary information.

### MATLAB live script files

The .mlx files contain both the code and the output that the code produces.

👀 To view the .mlx files click on the "File Exchange button"

▶️ To run the .mlx files in the free MATLAB on line click on "Run in MATLAB Online". The repo will be automatically cloned.

The Jupyter notebook version of the files is also given in the last column of the table below. Similarly to the .mlx files the Jupyter notebook files also contain both the code and the output produced by the code.

### Jupiter notebook files

To view the .ipynb files click on the corresponding link.

To run the .ipynb files inside the agnostic environment jupyter notebook follow the instructions in the file ipynbRunInstructions.md.

| FileName | View 👀 | Run ▶️ | Jupiter notebook |
|----------|---------|--------|-----------------|
| SI_Figure1.mlx : generate SI Figure 1 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure1.ipynb](SI_Figure1.ipynb) |
| SI_Figure2.mlx : generate SI Figure 2 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure2.ipynb](SI_Figure2.ipynb) |
| SI_Figure3.mlx : generate SI Figure 3 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure3.ipynb](SI_Figure3.ipynb) |
| SI_Figure4.mlx : generate SI Figure 4 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure4.ipynb](SI_Figure4.ipynb) |
| SI_Figure5.mlx : generate SI Figure 5 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure5.ipynb](SI_Figure5.ipynb) |
| SI_Figure6.mlx : generate SI Figure 6 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure6.ipynb](SI_Figure6.ipynb) |
| SI_Figure7.mlx : generate SI Figure 7 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Figure7.ipynb](SI_Figure7.ipynb) |
| SI_Table1.mlx : generate SI Table 1 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Table1.ipynb](SI_Table1.ipynb) |
| SI_Table2.mlx : generate SI Table 2 | 🔄 File Exchange | 🔄 Open in MATLAB Online | [SI_Table2.ipynb](SI_Table2.ipynb) |

Remark: in order to run the files we assume that the free MATLAB Add On FSDA must be installed.

## Additional Information

For questions or issues regarding the replication code, please open an issue in this repository.

> Author information and additional acknowledgments will be added after the peer review process is complete.
