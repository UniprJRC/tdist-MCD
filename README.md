# tdist-MCD
Code to reproduce the figures of paper "Robust distances and multivariate outlier detection under heavy tails"

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Robust distances and multivariate outlier detection under heavy tails</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: #24292e;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            padding-bottom: 0.3em;
            border-bottom: 1px solid #eaecef;
        }
        h2 {
            padding-bottom: 0.3em;
            border-bottom: 1px solid #eaecef;
        }
        code {
            background-color: rgba(27, 31, 35, 0.05);
            border-radius: 3px;
            padding: 0.2em 0.4em;
            font-family: SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace;
        }
        .toc {
            background-color: #f6f8fa;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 3px;
        }
        .note {
            background-color: #fffbe6;
            border-left: 4px solid #ffd33d;
            padding: 15px;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <h1>Robust distances and multivariate outlier detection under heavy tails</h1>

    <div class="note">
        <p><strong>Note:</strong> This repository contains code and instructions for replicating the results of a paper currently under peer review. Author information is intentionally omitted.</p>
    </div>

    <h2>Abstract</h2>
    <p>
        Heavy-tailed distributions, such as the Student-<i>t</i> distribution, have long been advocated as "robust" models for multivariate data in many fields. The underlying rationale is that robustness should be achieved by letting the classical maximum-likelihood estimators accommodate extreme observations naturally arising from the process under investigation. However, there is growing recognition that contamination might also occur under non-Gaussian scenarios. In this work we develop a unified approach which exploits high-breakdown estimation to ensure robust estimation of location, scatter and tail parameters under contamination of a multivariate Student-<i>t</i> distribution, when the latter is assumed to rule the data generating process of the uncontaminated part of the data. The framework that allows us to achieve our unified approach is the theory of generalized radius processes. In this framework, we first obtain the influence function of the main statistical functionals associated to robust Mahalanobis distances. We then suggest new statistics for measuring conformance to the multivariate Student-<i>t</i> distribution and an automatic procedure to infer the true values of the degrees of freedom and of the contamination rate. Along our path, we tackle several computational challenges associated to Monte Carlo estimation of the required radius-process quantiles and we provide extensive simulation evidence of the accuracy of our method.
    </p>

    <h2>Contents</h2>
    <div class="toc">
        <h3>Main Document</h3>
        <ul>
            <li><a href="#main-figures">Figures (15)</a></li>
            <li><a href="#main-tables">Tables (1)</a></li>
        </ul>

        <h3>Supplementary Information</h3>
        <ul>
            <li><a href="#si-figures">Figures (7)</a></li>
            <li><a href="#si-tables">Tables (2)</a></li>
        </ul>
    </div>

    <h2 id="replication">Replication Instructions</h2>
    <p>This repository contains code and data to replicate all figures and tables from both the main manuscript and the supplementary information document.</p>

    <h3>Requirements</h3>
    <p>Code for replication uses the following dependencies:</p>
    <!-- List your dependencies here -->
    <ul>
        <li>R version X.X.X or higher</li>
        <li>R packages: [list required packages]</li>
    </ul>

    <h3>Setup</h3>
    <p>To prepare your environment for replication:</p>
    <ol>
        <li>Clone this repository: <code>git clone https://github.com/username/reponame.git</code></li>
        <li>Navigate to the repository directory: <code>cd reponame</code></li>
        <li>Install required R packages: <code>Rscript install_packages.R</code></li>
    </ol>

    <h2 id="main-document">Main Document</h2>
    <p>This section provides instructions for reproducing all figures and tables from the main manuscript.</p>

    <h3 id="main-figures">Figures</h3>
    
    <h4>Figure 1</h4>
    <p>Description of Figure 1</p>
    <p>To reproduce: <code>Rscript code/figure1.R</code></p>
    
    <h4>Figure 2</h4>
    <p>Description of Figure 2</p>
    <p>To reproduce: <code>Rscript code/figure2.R</code></p>
    
    <!-- Continue for all 15 figures -->
    <h4>Figure 3-15</h4>
    <p>Description of remaining figures</p>
    <p>To reproduce Figures 3-15: <code>Rscript code/figures_3_to_15.R</code></p>
    
    <h3 id="main-tables">Tables</h3>
    
    <h4>Table 1</h4>
    <p>Description of Table 1</p>
    <p>To reproduce: <code>Rscript code/table1.R</code></p>
    
    <h2 id="supplementary-information">Supplementary Information</h2>
    <p>This section provides instructions for reproducing all figures and tables from the supplementary information document.</p>
    
    <h3 id="si-figures">Figures</h3>
    
    <h4>SI Figure 1</h4>
    <p>Description of SI Figure 1</p>
    <p>To reproduce: <code>Rscript code/si_figure1.R</code></p>
    
    <!-- Continue for all 7 SI figures -->
    <h4>SI Figures 2-7</h4>
    <p>Description of remaining SI figures</p>
    <p>To reproduce SI Figures 2-7: <code>Rscript code/si_figures_2_to_7.R</code></p>
    
    <h3 id="si-tables">Tables</h3>
    
    <h4>SI Table 1</h4>
    <p>Description of SI Table 1</p>
    <p>To reproduce: <code>Rscript code/si_table1.R</code></p>
    
    <h4>SI Table 2</h4>
    <p>Description of SI Table 2</p>
    <p>To reproduce: <code>Rscript code/si_table2.R</code></p>
    
    <h2>Additional Information</h2>
    <p>For questions or issues regarding the replication code, please open an issue in this repository.</p>
    
    <div class="note">
        <p>Author information and additional acknowledgments will be added after the peer review process is complete.</p>
    </div>
</body>
</html>
