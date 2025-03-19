function f_R = radiusDensity(r,p,nu)
%radiusDensity computes the non-squared Mahalanobis distance density
%
%<a href="matlab: docsearchFS('radiusDensity')">Link to the help function</a>
%
% Given the random variable $X$, with density $f_X(x)$ normally or
% $t$-distributed, $\mu=E[X]$, $\Sigma=Var[X]$, and radius $R = \sqrt
% \left( (X-\mu)' \Sigma^(-1) (X-\mu) \right)$, this function returns the
% radius density $f_R(r)$ for any $r>0$.
%
%  Required input arguments:
%
%       r     : radius value. Scalar. The radius value, possibly computed  
%               from a multivariate sample $X$. 
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
%  Output:
%
%    f_R : The radius density. 
%
%  Optional Output:
%
% See also: radiusQuantile
%
% References:
%
% Barabesi, L. and Cerioli, A. and García-Escudero, L.A. and Mayo-Iscar, A.
% (2023), Consistency factor for the MCD estimator at the Student-t
% distribution. Statistics and Computing. Vol. 33, Num. 132, 1-17.
%
%
% Copyright 2008-2023.
% Written by FSDA team
%
%<a href="matlab: docsearchFS('radiusDensity')">Link to the help page for this function</a>
%
%$LastChangedDate::                      $: Date of the last commit
%
% Examples:
%
%   
%{
    % Radius density for normal and t-distribution
    n  = 100;
    p  = 2;
    nu = 3;
    alpha = (n-(1:n)+1) / (n+1);  
    rN = chi2inv(alpha,p);
    rt = (1 - betainv(alpha,p/2,nu/2)).^(-1);
    rt = (rt - 1) * (nu - 2);
    rt = sqrt(rt);

    dent   = radiusDensity(rt , p, nu); 
    denN   = radiusDensity(rN , p); 
    plot(rt,denN)
    hold on;
    plot(rN,dent)
    ylabel('radius density','Fontsize',16);
    xlabel('r','Fontsize',16);
    hl=legend('$X \sim N$' , '$X \sim t$');
    set(hl,'Interpreter','Latex','Fontsize',20);

%}

if nargin<3 || isempty(nu) || nu <= 0
    % $f_X(x)$ is Normal. The squared Mahalanobis distance of a Gaussian
    % distribution is Chi-Square distributed but here we need the  
    % non-squared distances.
    A  = r.^(p-1) .* exp(-(r.^2)/2);
    B  = 2^(p/2 - 1) * gamma(p);
    f_R = A/B;
else
    % $f_X(x)$ is T. The non-squared Mahalanobis distance of a T
    % distribution follows this:
    A = 2*(beta(nu/2,p/2)*(nu-2)^(p/2))^(-1);
    B = r.^(p-1);
    C = (1 + (r.^2/(nu-2))).^(-(nu+p)/2);
    f_R = A .* B .* C;

    %{
    % This is equivalent to the above, using the gamma function
    Ar = (2*gamma((nu+p)/2)) / (gamma(p/2)*gamma(nu/2)*(nu-2)^(p/2));
    Br = r.^(p-1);
    Cr = (1 + 1/(nu-2) * r.^2) .^ (-(nu+p)/2);
    f_R2 = Ar .* Br .* Cr;
    %}

end

f_R = f_R(:);

end
%FScategory:UTISTAT

