function [data, labels] = contam_t_uniform(n, p, nu, epsilon, J, shift, je)
% Generate contaminated data from t-distribution with uniform contamination
%
% Inputs:
% n  - total number of observations
% p  - dimension of the data
% nu - degrees of freedom for t-distribution
% epsilon - contamination proportion (between 0 and 0.5)
% J - scalar with the scale value (e.g., J can be in 1:5)
% shift - scalar with the displacement value
% je - scalar for the exponent of J (e.g, je = p)
%
% Outputs:
% X - matrix of size (n*length(J)) x p containing all datasets
% labels - numeric array of size (n*length(J)) x 1 with binary labels

% Input validation
%assert(epsilon > 0 && epsilon < 0.5, 'epsilon must be between 0 and 0.5');
%assert(nu > 2, 'degrees of freedom must be > 2');
%assert(p > 0 && floor(p) == p, 'dimension must be positive integer');

%{
    n=500;
    p=5;
    nu=5;
    epsilon=0.1;
    C = [];
    shift = 5;
    for J=0:4; 
        [data, labels] = contam_t_uniform(n, p, nu, epsilon, J, shift, C);
        subplot(1,5,J+1);
        gscatter(data(:,1),data(:,2),labels);
        if J==0
            title('$\epsilon=0$','Interpreter','Latex','FontSize',25);
        else
            title(['$\epsilon=0.1$' '-- J=' num2str(J)],'Interpreter','Latex','FontSize',25);
        end    
        xl = xlim; yl = ylim;
        xlim(1.1*xl); ylim(1.1*yl); 
    end
%}

%{
    n=500;
    p=5;
    nu=5;
    epsilon=0.1;
    C = [];
    shift = 10;
    for J=1:4;
        [data, labels] = contam_t_uniform(n, p, nu, epsilon, J, shift, C);
        subplot(2,2,J);
        gscatter(data(:,1),data(:,2),labels);
        if J==0
            title('$\epsilon=0$','Interpreter','Latex','FontSize',25);
        else
            title(['$\epsilon=0.1$' '-- J=' num2str(J)],'Interpreter','Latex','FontSize',25);
        end    
        xl = xlim; yl = ylim;
        xlim(1.1*xl); ylim(1.1*yl); 
    end

    if ~exist('Fig11','dir')
        mkdir('Fig11');
    end
    hfig = gcf;
    saveas(hfig,'./Fig11/Fz_contamination.fig' , 'fig');
    pause(0.5);
    saveas(hfig,'./Fig11/Fz_contamination.png' , 'png');
    pause(0.5);
    saveas(hfig,'./Fig11/Fz_contamination.eps' , 'epsc');

%}

if nargin < 7 || isempty(je)
    je = p;
end

if nargin < 6 || isempty(shift)
    shift = 0;
end

if nargin < 5 || isempty(J)
    J = 1;
end

if epsilon == 0
    data    = randn(n,p) .* (sqrt(nu ./ chi2rnd(nu,n,1)));
    labels  = zeros(n , 1);
else

    % Calculate number of clean and contaminated observations
    n_clean  = floor(n * (1 - epsilon));
    n_contam = n - n_clean;

    % Generate clean observations from multivariate t-distribution
    %{
        % First generate multivariate normal
        Z = randn(n_clean, p);
        % Generate chi-square random variables
        chi_sq = chi2rnd(nu, n_clean, 1) / nu;
        % Combine to create multivariate t
        clean_data = Z ./ sqrt(repmat(chi_sq, 1, p));
    %}
    clean_data = randn(n_clean,p) .* (sqrt(nu ./ chi2rnd(nu,n_clean,1)));

    % Generate uniform contamination in hyper-rectangle of width 20/(J^je)
    width       = 20 / (J^je);
    lower_bound = shift - width/2;
    upper_bound = shift + width/2;
    contam_data = unifrnd(lower_bound, upper_bound, n_contam, p);

    % Combine clean and contaminated data
    current_data    = [clean_data; contam_data];
    current_labels  = [zeros(n_clean, 1); ones(n_contam, 1)];

    % Randomly shuffle the data and labels together
    idx     = randperm(n);
    data    = current_data(idx, :);
    labels  = current_labels(idx);

end
end
