%%  interpolating functions

function [c05sup,  c05and] = predict_critical(fit_c05sup,fit_c05ad,alpha0a,n)
c05sup = fit_c05sup(alpha0a,log(n));
c05and = fit_c05ad(alpha0a,log(n));
end
