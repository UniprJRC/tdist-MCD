%%  interpolating functions

function [fit_c05sup, fit_c05ad, gof_c05sup, gof_c05ad] = fit_critical(ksad,vv,nunu)

% We interpolate the estimated values using lowess.

% The names “lowess” and “loess” are derived from the term “locally
% weighted scatter plot smooth,” as both methods use locally weighted
% linear regression to smooth data.

% The smoothing process is considered local because, like the moving
% average method, each smoothed value is determined by neighboring data
% points defined within the span. The process is weighted because a
% regression weight function is defined for the data points contained
% within the span. In addition to the regression weight function, you can
% use a robust weight function, which makes the process resistant to
% outliers. Finally, the methods are differentiated by the model used in
% the regression: lowess uses a linear polynomial, while loess uses a
% quadratic polynomial.


alphamin   = 0.05;
alphamax   = 1; %0.30;
iiraw = find((ksad.v == vv) .* (ksad.nu == nunu) .* (ksad.alpha >= alphamin) .* (ksad.alpha <= alphamax));

if isempty(iiraw)
    error('Number of variables or degrees of freedom are out of range');
end

ft2     = fittype( 'loess' );
opts2   = fitoptions('Method', 'LowessFit' , ...
    'Normalize', 'on', ...
    'Robust', 'off',...
    'Span', 0.2);

[fit_c05sup, gof_c05sup] = fit( [ksad.alpha(iiraw) log(ksad.n(iiraw))],ksad.KolmogorovSmirnov(iiraw), ft2, opts2 );
[fit_c05ad,  gof_c05ad]  = fit( [ksad.alpha(iiraw) log(ksad.n(iiraw))],ksad.AndersonDarling(iiraw),   ft2, opts2 );

end

