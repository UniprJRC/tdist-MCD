function F_R_inverse = radiusQuantile(C,p,nu)
% Generalised radius for the Mahalanobis Squared Distance
%
%<a href="matlab: docsearchFS('radiusQuantile')">Link to the help function</a>
%
% This is $F_{R}^{-1}$. 
%
% Critical threshold derived from the Mahalanobis Squared Distance 
% distribution for normal or Student-t population. 
%
%  Required input arguments:
%
%     C : Confidence level. Scalar. Number between 0 and 1 indicating
%               the fraction of units not trimmed (1-\alpha). 
%               If the function is used to determine a cut-off value for the
%               estimator, C is the confidence level.
%               In this case, usually C = 0.95, 0.975 0.99 (individual alpha)
%               or 1-0.05/n, 1-0.025/n, 1-0.01/n (simultaneous alpha).
%               Default value is 0.975
%               Example - 'conflev',0.99
%               Data Types - double
%
%       p     : Multivariate dimension. Scalar. Number of variables in the 
%               multivariate sample. 
%               Example - 'p',2
%               Data Types - double
%
%  Optional input arguments:
%
%       nu    : Degrees of freedom. Scalar. If this optional argument is 
%               provided, then the sample is assumed to be heavy-tailed and 
%               modelled by a Student-t distribution with nu degrees of 
%               freedom. nu must be a positive value. 
%               Example - 'nu',5
%               Data Types - double
%
%  Output:
%
%  F_R_inverse : Cutoff value. Scalar. The cutoff value for the Mahalanobis 
%               Squared Distances distribution. 
%               
% More About:
%
% Mahalanobis distances measure the distance of a sample unit from the mean
% of a distribution, taking into account the correlation between the units
% in the covariance matrix. If $x$ is an observation from a multivariate
% distribution with mean $\mu$ and covariance $\Sigma$, the Mahalanobis
% squared distance (MSD) of $x$ from $\mu$ is $D^{2}=(x − \mu)^{t}
% \Sigma^{-1} (x − \mu)$. When $x$ is from a $p$-dimensional multivariate
% normal with known mean and covariance, the population MSD is distributed
% as a chi-squared $\chi_{p}^{2}$ random variable with $\nu$ degrees of
% freedom (Mardia et al, 1979). Then, to test the deviation of an
% observation from the multivariate normal assumption we can compare its
% MSD with an appropriate quantile of the chi-squared distribution: the
% observation will be considered an outlier if the associated $D^{2}$ value
% is larger than the critical value of the chi-squared distribution. There
% are known limitations to the application of this cut-off, for example
% when the sample is high dimensional and its size is not sufficiently
% high. In this case the distribution of the sample MSD is a scaled Beta
% distribution (Gnanadesikan and Kettenring, 1972). For continuous
% Student-t samples, which account for heavy-tailed distributions, the
% appropriate cutoff value depends from a standard Beta distribution with
% shape parameters $p/2$ and $\nu/2$, as shown by Barabesi et al (2023).
%
% See also: mcd.m
%
% References:
%
% Gnanadesikan, R. and Kettenring, J. R. (1972), Robust estimates,
% residuals, and outlier detection with multiresponse data. Biometrics,
% 28:81–124.
%
% Barabesi, L. and Cerioli, A. and García-Escudero, L.A. and Mayo-Iscar,
% A. (2023), Trimming heavy-tailed multivariate data. Submitted. 
%
% Mardia, K. and Kent, J. and Bibby, J. (1979), Multivariate Analysis,
% Academic Press, New York.
%
% Rousseeuw, P.J. and Van Driessen, K. (1999), A fast algorithm for the
% minimum covariance determinant estimator, Technometrics, 41:212-223.
%
% Maronna, R.A., Martin D. and Yohai V.J. (2006), "Robust Statistics,
% Theory and Methods", Wiley, New York.
%
%
% Copyright 2008-2023.
% Written by FSDA team
%
%
%<a href="matlab: docsearchFS('msdcutoff')">Link to the help page for this function</a>
%
%$LastChangedDate::                      $: Date of the last commit
%
% Examples:
%
%{
    % cutoff for a standard Normal.
    n  = 100;
    p  = 3;
    conflev = 0.975;
    cutoffN = msdcutoff(conflev,p);
%}

%{
    % cutoff for a Student-t.
    n  = 100;
    p  = 3;
    nu = 5;
    cutoffT = msdcutoff(conflev,p,nu);
%}

%{
    %% cutoff values for robust squared Mahalanobis distances.
    
    n  = 100;
    p  = 3;
    nu = 5;
    conflev = 0.975;

    % sample from the T
    Yt = random('T',nu,[n,p]); 
    Yn = random('Normal',0,1,[n,p]); 

    % mcd with the T-model
    RAWt = mcd(Yt,'modelT',nu,'plots',0);

    % mcd with the Normal-model
    RAWn = mcd(Yn,'plots',0);

    % T-cutoff
    cutoffT = msdcutoff(conflev,p,nu);

    % Normal-cutoff
    cutoffN = msdcutoff(conflev,p);

    plot(1:n,RAWt.md,'xr' , 1:n,RAWn.md,'ob'); 
    hold on;
    line([1 , n] , [cutoffT , cutoffT] , 'Color', 'r');
    line([1 , n] , [cutoffN , cutoffN] , 'Color', 'b');
    legend({'Student-t','Normal','cutoff-t','cutoff Normal'});

%}

if nargin < 3 || isempty(nu) || nu <= 0
    F_R_inverse = chi2inv(C,p);
else
    F_R_inverse = (1 - betainv(C,p/2,nu/2)).^(-1);
    F_R_inverse = (F_R_inverse - 1) * (nu - 2);
end
F_R_inverse = sqrt(F_R_inverse);
end

%FScategory:UTISTAT
