%% Data generation function

function [data, labels] = contam_t_normal(n, p, nu, epsilon, shift)
% Generate contaminated data from t-distribution with normal contamination
%
% Inputs:
% n  - total number of observations
% p  - dimension of the data
% nu - degrees of freedom for t-distribution
% epsilon - contamination proportion (between 0 and 0.5)
% shift - scalar with the displacement value
%
% Outputs:
% X - matrix of size (n*length(J)) x p containing all datasets
% labels - numeric array of size (n*length(J)) x 1 with binary labels

if epsilon == 0
    data    = randn(n,p) .* (sqrt(nu ./ chi2rnd(nu,n,1)));
    labels  = zeros(n , 1);
else

    % Calculate number of clean and contaminated observations
    n_clean  = floor(n * (1 - epsilon));
    n_contam = n - n_clean;

    clean_data = randn(n_clean,p) .* (sqrt(nu ./ chi2rnd(nu,n_clean,1)));

    % Generate normal contamination
    contam_data = randn(n_contam,p) + shift;

    % Combine clean and contaminated data
    current_data    = [clean_data; contam_data];
    current_labels  = [zeros(n_clean, 1); ones(n_contam, 1)];

    % Randomly shuffle the data and labels together
    idx     = randperm(n);
    data    = current_data(idx, :);
    labels  = current_labels(idx);

end
end
