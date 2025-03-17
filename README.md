# tdist-MCD

Code to reproduce the figures of paper:

# Robust distances and multivariate outlier detection under heavy tails
# Main manuscript and Supplementary Information

> **Note:** This repository contains code and instructions for replicating the results of a paper currently under peer review. Author information is intentionally omitted.

## Abstract

Heavy-tailed distributions, such as the Student-*t* distribution, have long been advocated as "robust" models for multivariate data in many fields. The underlying rationale is that robustness should be achieved by letting the classical maximum-likelihood estimators accommodate extreme observations naturally arising from the process under investigation. However, there is growing recognition that contamination might also occur under non-Gaussian scenarios. In this work we develop a unified approach which exploits high-breakdown estimation to ensure robust estimation of location, scatter and tail parameters under contamination of a multivariate Student-*t* distribution, when the latter is assumed to rule the data generating process of the uncontaminated part of the data. The framework that allows us to achieve our unified approach is the theory of generalized radius processes. In this framework, we first obtain the influence function of the main statistical functionals associated to robust Mahalanobis distances. We then suggest new statistics for measuring conformance to the multivariate Student-*t* distribution and an automatic procedure to infer the true values of the degrees of freedom and of the contamination rate. Along our path, we tackle several computational challenges associated to Monte Carlo estimation of the required radius-process quantiles and we provide extensive simulation evidence of the accuracy of our method.

## Contents

### Main manuscript
- [Code Files](#main-document-code-files)
- [Replication Instructions](#replication-instructions)

### Supplementary Information
- [Code Files](#supplementary-information-code-files)

## Replication Instructions

This repository contains code and data to replicate all figures and tables from both the main manuscript and the supplementary information document. The MCD and few other functions rely on the free MATLAB Add On FSDA, which must be installed.

### Requirements

Code for replication uses the following dependencies:
- MATLAB, which can be used in two modalities:
-   1) In a local standalone licensed installation 
-   2) In the license-free MATLAB online (https://it.mathworks.com/products/matlab-online.html)
- R is used version X.X.X or higher
- R packages: [list required packages]

### Setup

To prepare your local environment for replication:
1. Clone this repository: `git clone https://github.com/UniprJRC/tdist-MCD.git`
2. Navigate to the repository directory: `cd <your path to tdist-MCD>
3. Install FSDA from "Install App" of the standard MATLAB distribution (see https://it.mathworks.com/matlabcentral/fileexchange/72999-fsda-flexible-statistics-data-analysis-toolbox). FSDA requires the Statistical and Machine Learning Toolbox. The parallel processing Toolbox is necessary if the reader needs to replicate the estimates, which take lot of time otherwise.
4. Install required R packages: `Rscript install_packages.R`

## Main Document Code Files

In the table below you can find the original source (MATLAB live script): .mlx file and the corresponding .ipynb file.

### MATLAB live script files

The .mlx files contain both the code and the output that the code produces.

👀 To view the .mlx files click on the "File Exchange button"

▶️ To run the .mlx files in the free MATLAB on line click on "Run in MATLAB Online". The repo will be automatically cloned.

The Jupyter notebook version of the files is also given in the last column of the table below. Similarly to the .mlx files the Jupyter notebook files also contain both the code and the output produced by the code.

### Jupiter notebook files

To view the .ipynb files click on the corresponding link.

To run the .ipynb files inside the agnostic environment jupyter notebook follow the instructions in the file [![FipynbRunInstructions.md](https://github.com/UniprJRC/tdist-MCD/blob/main/aux/ipynbRunInstructions.md)


## Main Document Code Files: MATLAB functions

| FileName | View 👀 | Run ▶️ | Jupiter notebook |
|----------|---------|--------|-----------------|
|`Figure3.mlx`:  generate Figure 3  | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure3.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure3.mlx) | [Figure3.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure3.ipynb) |
|`Figure6.mlx`:  generate Figure 6  | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure6.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure6.mlx) | [Figure6.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure6.ipynb) |
|`Figure7.mlx`:  generate Figure 7  | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure7.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure7.mlx) | [Figure7.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure7.ipynb) |
|`Figure8.mlx`:  generate Figure 8  | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure8.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure8.mlx) | [Figure8.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure8.ipynb) |
|`Figure9.mlx`:  generate Figure 9  | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure9.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure9.mlx) | [Figure9.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure9.ipynb) |
|`Figure10.mlx`: generate Figure 10 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure10.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure10.mlx) | [Figure10.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure10.ipynb) |
|`Figure11.mlx`: generate Figure 11 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure11.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure11.mlx) | [Figure11.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure11.ipynb) |
|`Figure12.mlx`: generate Figure 12 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure12.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure12.mlx) | [Figure12.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure12.ipynb) |
|`Figure13.mlx`: generate Figure 13 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure13.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure13.mlx) | [Figure13.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure13.ipynb) |
|`Figure14.mlx`: generate Figure 14 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure14.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure14.mlx) | [Figure14.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure14.ipynb) |
|`Figure15.mlx`: generate Figure 15 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure15.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure15.mlx) | [Figure15.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure15.ipynb) |
|`Table1.mlx`  : generate Table 1   | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure15.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure15.mlx) | [Figure15.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Table1.ipynb) |


## Main Document Code Files: R functions

| FileName | View 👀 | Run ▶️ | Jupiter notebook |
|----------|---------|--------|-----------------|
|`Figure1.mlx`: generate Figure 1 in R | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure1.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure1.mlx) | [Figure1.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure1.ipynb) |
|`Figure2.mlx`: generate Figure 2 in R | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure2.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure2.mlx) | [Figure2.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure2.ipynb) |
|`Figure4.mlx`: generate Figure 4 in R | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure4.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure4.mlx) | [Figure4.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure4.ipynb) |
|`Figure5.mlx`: generate Figure 5 in R | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure5.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure5.mlx) | [Figure5.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/Figure5.ipynb) |


## Supplementary Information Code Files

In the table below you can find the original source (MATLAB live script): .mlx file and the corresponding .ipynb file for the supplementary information.

### MATLAB live script files

The .mlx files contain both the code and the output that the code produces.

👀 To view the .mlx files click on the "File Exchange button"

▶️ To run the .mlx files in the free MATLAB on line click on "Run in MATLAB Online". The repo will be automatically cloned.

The Jupyter notebook version of the files is also given in the last column of the table below. Similarly to the .mlx files the Jupyter notebook files also contain both the code and the output produced by the code.

### Jupiter notebook files

To view the .ipynb files click on the corresponding link.

To run the .ipynb files inside the agnostic environment jupyter notebook follow the instructions in the file ipynbRunInstructions.md under the aux folder.

| FileName | View 👀 | Run ▶️ | Jupiter notebook |
|----------|---------|--------|-----------------|
|`SI_Figure1.mlx`: generate SI Figure 1 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure1.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure1.mlx) | [Figure1.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure1.ipynb) |
|`SI_Figure2.mlx`: generate SI Figure 2 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure2.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure2.mlx) | [Figure2.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure2.ipynb) |
|`SI_Figure3.mlx`: generate SI Figure 3 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure3.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure3.mlx) | [Figure3.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure3.ipynb) |
|`SI_Figure4.mlx`: generate SI Figure 4 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure4.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure4.mlx) | [Figure4.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure4.ipynb) |
|`SI_Figure5.mlx`: generate SI Figure 5 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure5.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure5.mlx) | [Figure5.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure5.ipynb) |
|`SI_Figure6.mlx`: generate SI Figure 6 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure6.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure6.mlx) | [Figure6.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure6.ipynb) |
|`SI_Figure7.mlx`: generate SI Figure 7 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure7.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure7.mlx) | [Figure7.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Figure7.ipynb) |
|`SI_Table1.mlx` : generate SI Table 1 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure8.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure8.mlx) | [Figure8.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Table1.ipynb) |
|`SI_Table2.mlx` : generate SI Table 2 | [![File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Ff026de45-4ab8-44ed-85a3-1549ae68987b%2F1741121020%2Ffiles%2FFigure9.mlx&embed=web) | [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=UniprJRC/tdist-MCD&file=Figure9.mlx) | [Figure9.ipynb](https://github.com/UniprJRC/tdist-MCD/blob/main/SI_Table2.ipynb) |


Remark: in order to run the files we assume that the free MATLAB Add On FSDA must be installed.

## Additional Information

For questions or issues regarding the replication code, please open an issue in this repository.

> Author information and additional acknowledgments will be added after the peer review process is complete.
