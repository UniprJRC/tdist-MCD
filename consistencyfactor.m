function eta_f = consistencyfactor(alpha,p,nu) 
%eta_f computes the consistency factor for a scatter matrix
%
%<a href="matlab: docsearchFS('eta_f')">Link to the help function</a>
%
% If $\Sigma(p)$ denotes the dispersion matrix when an elliptical
% population is conditioned on the central region $C_p$, then the
% dispersion matrix of the full sample $\Sigma$ is related to $\Sigma(p)$
% by a constant multiplier. This function is used to obtain this constant
% and, therefore, a consistent estimators of the scatter matrix $\Sigma$.
% The consistency factor is used to adapt all of the scatter matrix
% estimators obtained from trimming procedures. The function addresses both
% the normal and t-distribution cases.
%
%  Required input arguments:
%
%     alpha   : Trimming percentage. Scalar. Fraction of trimmed units in 
%               a multivariate sample. If $h$ represents the number of
%               units the central region $C_p$ (e.g. the units used for
%               fitting the scatter estimator) and $n$ the total number of
%               units in the sample, then $alpha = (1-(n-h)/n) = h/n$. 
%               Example - 'alpha',0.3
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
%               freedom. nu must be a positive value. The case nu=0 is
%               treated like if nu=[] or nu is not privided, that is we
%               have a Normal sample. Example - 'nu',5
%               Data Types - double
%
%  Output:
%
%    eta_f : The consistency factor. 
%
%  Optional Output:
%
% See also: mcd.m
%
% References:
%
% Liu, R.Y., Parelius, J.M. and Singh, K. (1999), Multivariate Analysis by
% Data Depth: Descriptive Statistics, Graphics and Inference. Annals Of
% Statistics, Vol. 27, No. 3, pp. 783-858.
%
%
% Copyright 2008-2023.
% Written by FSDA team
%
%<a href="matlab: docsearchFS('eta_f')">Link to the help page for this function</a>
%
%$LastChangedDate::                      $: Date of the last commit
%
% Examples:
%
%{
    n  = 100;
    p  = 2;
    nu = 3;

    % 20% trimming
    alpha0a = 0.2;

    % case 'T'
    Xt      = random('T',nu,[n,p]);
    % case 'N'
    XN      = random('Normal',0,1,[n,p]);

    X  = Xt;
    MU = mean(X);
    Sigma = cov(X);

    Ytilde  = bsxfun(@minus,X, MU);
    cfactor = consistencyfactor(alpha0a,p,nu);
    d       = sqrt(sum((Ytilde/Sigma.*cfactor).*Ytilde,2));

    

%}

%% Beginning of code

% Fraction of retained observations, whose covariance determinant will 
% be minimized. If a percentage alpha=1-h/n of units are trimmed by 
% the mcd, it is 1-alpha = h/n. 
retained = 1-alpha;

if nargin<3 || isempty(nu) || nu == 0
    % This is the standard case, applied when uncontaminated data
    % are assumed to come from a multivariate Normal model.

    a = chi2inv(retained,p);
    eta_f = retained/(chi2cdf(a,p+2));

else
    % This is the case of a heavy-tail scenario, when
    % uncontaminated data come from a multivariate Student-t
    % distribution. From Barabesi et al. (2023), Trimming
    % heavy-tailed multivariate data, submitted.

    integrand   = @(u) 1 ./ (1 - betainv(u,p/2,nu/2));
    theintegral = integral(integrand,0,retained);
    eta_f  = ((nu-2) / (retained*p) * theintegral - (nu - 2)/p)^(-1);
end
end

%FScategory:UTISTAT
