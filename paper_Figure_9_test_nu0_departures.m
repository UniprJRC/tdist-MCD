function [out, out_S] = paper_Figure_9_test_nu0_departures(...
    rep, n_values, p_values, alpha0_values, ...
    nu0_values, nu0_shifts)

% This function is used to generate Figure 9. It is called by function
% Figure9.mlx.

% The finite-sample quantiles for the KS and AD statistics of the radius
% process, obtained by Monte Carlo estimation, are used to produce
% inferential tools for detecting departures from the correct degrees of
% freedom. This function is used to estimate the power of this procedure.

% This function was originally called paper_Figure_9_simstudy_Algo_Power.m

%{
    clear all;
    close all;
    
    rep               = 1000;
    n_values          = [ ]; % take all n
    p_values          = [5];
    alpha0_values     = [0.025 0.05 0.10 0.15 0.20 0.25];

    nu0_values        = 5 ;
    nu0_shifts        = [-2 -1 0 1 2 15]; 
    
    [out, out_S] = paper_Figure_9_test_nu0_departures(rep, n_values, p_values, alpha0_values, nu0_values, nu0_shifts)

%}

%% data preparation

% Load the estimated statistics (radius process percentiles)
load('ksad','ksad');

ksad_numel      = size(ksad,1);
ksad.shift_nu   = zeros(ksad_numel,1);
ksad.cont_perc  = zeros(ksad_numel,1);

% the nu values used to generate the data
if isempty(nu0_values)
    nu0_values = unique(ksad.nu)';
end
numel_nu0       = numel(nu0_values);

% the n values
if isempty(n_values)
    n_values    = unique(ksad.n)';
end
numel_n         = numel(n_values);

% the p values 
if isempty(p_values)
    p_values    = unique(ksad.p)';
end
numel_p         = numel(p_values);

% the alpha_0 values
if isempty(alpha0_values)
    alpha0_values = unique(ksad.alpha)';
end
numel_alpha      = numel(alpha0_values);

% The nu-shifted values
if isempty(nu0_shifts)
    nu0_shifts = -6:1:6;
end
numel_nus      = numel(nu0_shifts);

% number of combinations
ncomb = numel_nus*numel_nu0*numel_p*numel_n*numel_alpha;                

% initialisation of the output variables
out_var_names = {'p','n','alpha0','nu_true','nu_shifted','ADpval_int','ADpval_est','KSpval_int','KSpval_est','KSaexe_int','KSaexe_est'};
n_pos         = length(out_var_names);
out           = NaN(ncomb , n_pos);

%% Loop

pos = 1;  % position of results in summary table

for nu_true = nu0_values

    for p = p_values

        [c05sup_fit, c05ad_fit] = fit_critical(ksad,p,nu_true);

        for n = n_values

            for alpha0a = alpha0_values

                disp('  -------  ');
                disp(['nu_true = ' num2str(nu_true) ' --- p = ' num2str(p) ' --- n = ' num2str(n) ' --- alpha0a = ' num2str(alpha0a)]);
                disp('  -------  ');

                % set the nu grid, with nu > 2
                nu_grid             = nu_true + nu0_shifts;
                nu_grid(nu_grid<3)  = [];
                nu_grid             = sort(nu_grid,'descend');
                %numel_nu            = numel(nu_grid);

                for nu = nu_grid

                    % alpha
                    alpha = (1:n)/(n+1);
                    % eta
                    %eta = 1 / consistencyfactor(1-alpha0a,v,nu);
                    % radius
                    r = radiusQuantile(1-alpha,p,nu);
                    r = r(:);
                    % density
                    den = radiusDensity(r,p,nu);

                    iraw       = find((ksad.p == p) .* (ksad.nu == nu_true) .* (ksad.n == n) .* (ksad.alpha == alpha0a));
                    c05sup_est = ksad.KolmogorovSmirnov(iraw);
                    c05and_est = ksad.AndersonDarling(iraw);

                    % find the corresponding KS bands
                    [c05sup_int,  c05and_int] = predict_critical(c05sup_fit, c05ad_fit, alpha0a, n);

                    % bands KS - based on interpolated stats
                    KS_ub_int = r + (c05sup_int/sqrt(n))./den;
                    KS_lb_int = r - (c05sup_int/sqrt(n))./den;

                    % bands KS - based on estimated stats
                    KS_ub_est = r + (c05sup_est/sqrt(n))./den;
                    KS_lb_est = r - (c05sup_est/sqrt(n))./den;

                    KScheck_int = zeros(rep,1);
                    KSsum_int   = zeros(rep,1);
                    ADcheck_int = zeros(rep,1);
                    KScheck_est = zeros(rep,1);
                    KSsum_est   = zeros(rep,1);
                    ADcheck_est = zeros(rep,1);

                    parfor B=1:rep

                        % generate (uncontaminated) data
                        X  = randn(n,p) .* (sqrt(nu_true ./ chi2rnd(nu_true,n,1)));

                        % compute MCD 
                        RAW = mcd(X,'modelT',nu,'bdp',alpha0a,'smallsamplecor',false,'nsamp',500,'refsteps',10,'plots',0,'msg',0,'nocheck',1);

                        %{
                        cfactor0a  = consistencyfactor(alpha0a,v);
                        Sigma_n    = RAW.cov / cfactor0a;
                        M_n        = RAW.loc;
                        %}

                        % non-squared MD
                        d = sqrt(RAW.md);

                        % empirical radius
                        emp_r = sort(d,'descend'); %d(n-(1:n)+1);
                        %empr_stats(B,:) = emp_r;

                        AD             = sum(((emp_r - r) .* den) .^2);
                        %ADstats(B)     = AD;

                        % KS  and AD statistics based on interpolated values
                        KScheck_int(B) = any(or(emp_r < KS_lb_int , emp_r > KS_ub_int))  ;
                        KSsum_int(B)   = sum(or(emp_r < KS_lb_int , emp_r > KS_ub_int))  ;
                        ADcheck_int(B) = AD > c05and_int;

                        % KS  and AD statistics based on estimated values
                        KScheck_est(B) = any(or(emp_r < KS_lb_est , emp_r > KS_ub_est))  ;
                        KSsum_est(B)   = sum(or(emp_r < KS_lb_est , emp_r > KS_ub_est))  ;
                        ADcheck_est(B) = AD > c05and_est;
                        

                    end % parfor B

                    % Kolmogorov Smirnov and Andersen Darling level
                    % based on interpolated values
                    KSpval_int = sum(KScheck_int)  / rep;
                    KSaexe_int = sum(KSsum_int./n) / rep;
                    ADpval_int = sum(ADcheck_int)  / rep;

                    % Kolmogorov Smirnov and Andersen Darling level
                    % based on estimated values
                    KSpval_est = sum(KScheck_est)/rep; 
                    KSaexe_est = sum(KSsum_est./n)/rep; 
                    ADpval_est = sum(ADcheck_est)/rep; 

                    out(pos,1)  = p;
                    out(pos,2)  = n;
                    out(pos,3)  = alpha0a;

                    out(pos,4)  = nu_true;
                    out(pos,5)  = nu;
                    
                    out(pos,6)  = ADpval_int;
                    out(pos,7)  = ADpval_est;

                    out(pos,8)  = KSpval_int;
                    out(pos,9)  = KSpval_est;

                    out(pos,10) = KSaexe_int;
                    out(pos,11) = KSaexe_est;
                    
                    pos=pos+1;

                end % nu grid

            end % alpha0a

        end % n

    end % v

end % nu_true

% final results
out_S = array2table(out, 'VariableNames',out_var_names);

% % save final results
% out_path = './results/';
% save([out_path filesep 'SummaryResults_out_S'] ,'out_S');
% excel_file_path1 = fullfile(out_path, 'SummaryResults_out_S.xlsx');
% writetable(out_S, excel_file_path1);

end
