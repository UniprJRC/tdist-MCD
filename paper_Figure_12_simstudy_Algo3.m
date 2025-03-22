function [out, out_S] = paper_Figure_12_simstudy_Algo3(...
    rep, n_values, p_values, alpha0_values, ...
    nu0_values, epsilon0_values, J_values, shift, ...
    saveResults)

%{
    clear all;
    close all;
    
    rep               = 5;
    n_values          = [250, 500, 1000];
    p_values          = 5;
    alpha0_values     = 0.25;

    nu0_values        = 5;
    epsilon0_values   = [0.05, 0.10 , 0.15, 0.16, 0.17, 0.18, 0.19, 0.20]; 

    J_values          = [1,2,3,4];
    
    shift             = 10; 
    %shift             = 5 ; 

    saveResults = false;

    [out, out_S] = paper_Figure_12_simstudy_Algo3(rep, n_values, p_values, alpha0_values, ...
        nu0_values, epsilon0_values, J_values, shift, saveResults)

%}   


%% data preparation

% Load the estimated statistics
load('ksad','ksad');

ksad_numel      = size(ksad,1);
ksad.shift_nu   = zeros(ksad_numel,1);
ksad.cont_perc  = zeros(ksad_numel,1);

if saveResults
    if ~exist('Fig12','dir')
        mkdir('Fig12');
    end
    out_path = './Fig12/'; 
end

% the nu values used to generate the data
if isempty(nu0_values)
    nu0_values = unique(ksad.nu)';
end
% normal case removed (conventionally, we use nu==0 for the normal case)
nu0_values(nu0_values==0) = [];
numel_nu0=numel(nu0_values);

% the n values
if isempty(n_values)
    n_values    = unique(ksad.n)';
end
numel_n         = numel(n_values);

% the p values (this is v, in ksad)
if isempty(p_values)
    p_values    = unique(ksad.p)';
end
numel_p         = numel(p_values);

% the alpha_0 values
if isempty(alpha0_values)
    alpha0_values = unique(ksad.alpha)';
end
numel_alpha       = numel(alpha0_values);

% The J values
if isempty(J_values)
    J_values = 1;
end
numel_J      = numel(J_values);

% The true data contamination percentage(s)
numel_epsilon0 = numel(epsilon0_values);

% number of combinations
ncomb = numel_J*numel_nu0*numel_epsilon0*numel_p*numel_n*numel_alpha;

% initialisation of the output variables
out_var_names = {'p','n','alpha0','ADpval_i','KSpval_i', 'KSaexe_i', ...
    'nu_true','epsilon_true','J', ...
    'epsilon_hat_mean','nu_hat_mean','epsilon_hat_std','nu_hat_std', ...
    'epsilon_hat_median','nu_hat_median', ...
    'mcd_TPR','mcd_FPR','mcd_FNR','num_non_nan'};
n_pos = length(out_var_names);
out = NaN(ncomb , n_pos);

% Initialize a table to store estimates of nu and epsilon in all replicates
baseColumns   = {'J','p', 'n', 'alpha0','nu_true', 'epsilon_true'};
repColumns    = cellstr(strcat('rep', num2str((1:rep)', '%d')));
colNames      = [baseColumns, repColumns'];
rowNames      = arrayfun(@(x) sprintf('nu_true_%d', x), 1:ncomb, 'UniformOutput', false);
out_B_nu      = array2table(zeros(ncomb, numel(baseColumns)+rep), 'RowNames', rowNames, 'VariableNames', colNames);
rowNames      = arrayfun(@(x) sprintf('epsilon_true_%d', x), 1:ncomb, 'UniformOutput', false);
out_B_epsilon = array2table(zeros(ncomb, numel(baseColumns)+rep), 'RowNames', rowNames, 'VariableNames', colNames);

%% Loop

pos = 1;      % position of results in summary table

for J = J_values
    % Data are generated with various contamination schemes

    for nu_true = nu0_values
        % Data are generated for various nu values

        for epsilon_true = epsilon0_values
            % A epsilon_true percentage of data are contaminated

            for p = p_values

                [fit_c05sup,  fit_c05ad] = fit_critical(ksad,p,nu_true);

                for n = n_values

                    for alpha0a = alpha0_values

                        KScheck_i       = NaN(rep,1);
                        ADcheck_i       = NaN(rep,1);
                        KSsum_i         = NaN(rep,1);

                        epsilon_hat     = NaN(rep,1);
                        nu_hat          = NaN(rep,1);

                        mcd_TPR         = NaN(rep,1);
                        mcd_FPR         = NaN(rep,1);
                        mcd_FNR         = NaN(rep,1);

                        disp('  -------  ');
                        disp(['nu_true = ' num2str(nu_true)  ' --- epsilon_true = ' num2str(epsilon_true) ' --- p = ' num2str(p) ' --- n = ' num2str(n) ' --- alpha0a = ' num2str(alpha0a)]);
                        disp('  -------  ');

                        % set the epsilon grid, with epsilon < alpha0a
                        epsilon_grid_step  = 0.01;
                        epsilon_grid       = 0:epsilon_grid_step:min(alpha0a,0.21);
                        numel_epsilon_grid = numel(epsilon_grid);
                        epsilon_grid       = sort(epsilon_grid,'ascend');

                        % set the nu grid, with nu > 2
                        s                   = [-2  0  3 14];
                        nu_grid             = nu_true + s;
                        nu_grid(nu_grid<3)  = [];
                        nu_grid             = sort(nu_grid,'descend');
                        numel_nu            = numel(nu_grid);

                        parfor B=1:rep   % PARFOR

                            % generate contaminated data
                            [X, Xlabels] = contam_t_uniform(n, p, nu_true, epsilon_true, J, shift, 4);

                            % compute MCD and take raw covariance matrix,
                            % not corrected with the consistency factor
                            RAW = mcd(X,'bdp',alpha0a,'smallsamplecor',false,'nsamp',500,'refsteps',10,'plots',0,'msg',0,'nocheck',1);
                            cfactor0a  = consistencyfactor(alpha0a,p);
                            Sigma_n    = RAW.cov / cfactor0a;
                            M_n        = RAW.loc;

                            % Initialize an exit flag
                            exitFlag = false;

                            % Outer while loop: Iterate over epsilon grid
                            i_epsilon = 0;
                            while ~exitFlag && i_epsilon<numel_epsilon_grid
                                i_epsilon = i_epsilon+1;
                                epsilon   = epsilon_grid(i_epsilon);

                                % set alpha0a_star and n_star
                                alpha0a_star = (alpha0a - epsilon) / (1 - epsilon);
                                n_star       = ceil(n * (1-epsilon));

                                % find the corresponding KS bands
                                [c05sup_i,  c05and_i] = predict_critical(fit_c05sup, fit_c05ad, alpha0a_star, n_star);

                                % Inner while loop: Iterate over the nu values
                                i_nu = 0;
                                while ~exitFlag && i_nu < numel_nu
                                    i_nu = i_nu+1;
                                    nu = nu_grid(i_nu);

                                    % Compute corrected covariance and non-squared
                                    % Mahalanobis distances based on alpha0a_star,
                                    % which is the actual trimming level required for the
                                    % correction factor in the robust estimate of \Sigma
                                    cov_star = Sigma_n * consistencyfactor(alpha0a_star, p, nu);
                                    md       = mahalFS(X, M_n, cov_star);
                                    d        = sqrt(md);

                                    % The empirical radius from n_star+1 to n
                                    emp_r    = sort(d,'descend');
                                    emp_r    = emp_r(n-n_star+1:n);

                                    % The theoretical bands for KS test
                                    alpha = (1:n_star)/(n_star+1);
                                    r = radiusQuantile((1-alpha),p,nu);
                                    r = r(:);
                                    den = radiusDensity(r,p,nu);
                                    KS_ub_i = r + (c05sup_i/sqrt(n_star))./den;
                                    KS_lb_i = r - (c05sup_i/sqrt(n_star))./den;

                                    % Check the KS and AD excedences
                                    KSsum_i(B)    = sum(or(emp_r < KS_lb_i , emp_r > KS_ub_i)) ;
                                    KScheck_i(B)  = any(or(emp_r < KS_lb_i , emp_r > KS_ub_i))  ;

                                    AD            = sum(((emp_r - r) .* den) .^2);
                                    ADcheck_i(B)  = AD > c05and_i;

                                    % Estimated nu and epsilon
                                    if KSsum_i(B) == 0
                                        epsilon_hat(B) = epsilon;
                                        nu_hat(B)      = nu;

                                        % set exitFlag to true and break
                                        exitFlag = true;

                                        disp(['Found ', num2str(KSsum_i(B)), ' excedences: ' 'Estimated nu = ' num2str(nu) ' and epsilon = ' num2str(epsilon)]);
                                        
                                        outliers = find(d > radiusQuantile(0.99,p,nu));
                                        [mcd_TPR(B), mcd_FPR(B), mcd_FNR(B)] = compute_outlier_detection_metrics(outliers, Xlabels);

                                    else
                                        % do nothing: the structures are initialised to nan
                                        disp(['Found ', num2str(KSsum_i(B)), ' excedences']);
                                    end

                                    % THIS IS TO CHECK CONVERGENCE ISSUES
                                    % PLOT ONLY ONCE
                                    % DEBUG ONLY: DOES NOT WORK WITH PARFOR
                                    if B == 1
                                        if and(abs(nu - nu_true)<eps , abs(epsilon - epsilon_true)<eps)
                                            disp(['nu=' num2str(nu) ' -- nu_true=' num2str(nu_true) ' -- epsilon=' num2str(epsilon) ' -- epsilon_true=' num2str(epsilon_true) ]);
                                            radius_plot_c05_bands(r, emp_r, KS_ub_i, KS_lb_i, alpha0a, nu_true, X, Xlabels, RAW);
                                        end
                                    end

                                end % s

                            end % epsilon

                        end % parfor B

                        % Kolmogorov Smirnov and Andersen Darling level
                        KSpval_i = sum(KScheck_i)  / rep;
                        KSaexe_i = sum(KSsum_i./n) / rep;
                        ADpval_i = sum(ADcheck_i)  / rep;

                        % save epsilon_hat and nu_hat: just in case something goes wrong ...
                        if saveResults

                            out_B_epsilon.J(pos) = J;
                            out_B_epsilon.n(pos) = n;
                            out_B_epsilon.p(pos) = p;
                            out_B_epsilon.alpha0(pos)       = alpha0a;
                            out_B_epsilon.nu_true(pos)      = nu_true;
                            out_B_epsilon.epsilon_true(pos) = epsilon_true;
                            out_B_epsilon(pos,numel(baseColumns)+1:end) = array2table(epsilon_hat');

                            out_B_nu.J(pos) = J;
                            out_B_nu.n(pos) = n;
                            out_B_nu.p(pos) = p;
                            out_B_nu.alpha0(pos)       = alpha0a;
                            out_B_nu.nu_true(pos)      = nu_true;
                            out_B_nu.epsilon_true(pos) = epsilon_true;
                            out_B_nu(pos,numel(baseColumns)+1:end) = array2table(nu_hat');

                        end

                        out(pos,1)  = p;
                        out(pos,2)  = n;
                        out(pos,3)  = alpha0a;

                        out(pos,4)  = ADpval_i;
                        out(pos,5)  = KSpval_i;
                        out(pos,6)  = KSaexe_i;

                        out(pos,7)  = nu_true;
                        out(pos,8)  = epsilon_true;
                        out(pos,9)  = J;

                        out(pos,10) = round(mean(epsilon_hat,'omitnan'),4);
                        out(pos,11) = round(mean(nu_hat,'omitnan'),4);
                        out(pos,12) = round(std(epsilon_hat,'omitnan'),4);
                        out(pos,13) = round(std(nu_hat,'omitnan'),4);

                        out(pos,14) = round(median(epsilon_hat,'omitnan'),4);
                        out(pos,15) = round(median(nu_hat,'omitnan'),4);

                        out(pos,16) = round(mean(mcd_TPR,'omitnan'),4);
                        out(pos,17) = round(mean(mcd_FPR,'omitnan'),4);
                        out(pos,18) = round(mean(mcd_FNR,'omitnan'),4);

                        out(pos,19) = sum(~isnan(epsilon_hat));

                        pos=pos+1;

                        % save partial results: just in case something goes wrong ...
                        out_S_temp = array2table(out, 'VariableNames',out_var_names);
                        if saveResults
                            save([out_path filesep 'out_S_temp'],'out_S_temp');
                        end
                    end % alpha0a

                end % n

            end % v

        end % epsilon_true

    end % nu_true

end %jval

% save final results
epsilonhat = ['Algo3_epsilon_hat_s' num2str(shift)]; %  'DetailedResults_out_B_epsilon'
nuhat      = ['Algo3_nu_hat_s' num2str(shift)];      %  'DetailedResults_out_B_nu'

out_S = array2table(out, 'VariableNames',out_var_names);
if saveResults
    save([out_path filesep 'Algo3_SummaryResults_out_S'] ,'out_S');
    save([out_path filesep epsilonhat],'out_B_epsilon');
    save([out_path filesep epsilonhat],'out_B_nu');

    % Save also as Excel file
    excel_file_path1 = fullfile(out_path, 'Algo3_SummaryResults_out_S.xlsx');
    writetable(out_S, excel_file_path1);
    excel_file_path2 = fullfile(out_path, [epsilonhat '.xlsx']);
    writetable(out_B_epsilon, excel_file_path2);
    excel_file_path3 = fullfile(out_path, [nuhat '.xlsx']);
    writetable(out_B_nu, excel_file_path3);
end

end




%% plot bands and mcd scatter

function [hfigBands , hfigMCD] = radius_plot_c05_bands(r, emp_r, KS_ub_i, KS_lb_i, alpha0, nu, X, Xlabels, RAW)

addtitle = true;
n = size(r,1);
p = numel(RAW.loc);
alpha = (1:n)/(n+1);

thetitle = {['$' 'n=' num2str(n)  '\mbox{ ; } \; \alpha_0=' num2str(alpha0) '\mbox{ ; } \; p=' num2str(p) '\mbox{ ; } \; \nu=' num2str(nu) '$']};

FontSize    = 20;
SizeAxesNum = 18;
grayColor = [.5 .5 .5];

% plot bands

hfigBands = figure; 
afig = gca(hfigBands);
plot(alpha,r , 'Color', grayColor , 'LineWidth', 1.5, 'LineStyle' , '--');hold on;
plot(alpha,emp_r, 'r', 'LineWidth', 2, 'LineStyle' , '-');
plot(alpha,KS_ub_i , 'k', 'LineWidth', 1, 'LineStyle' , '-');
plot(alpha,KS_lb_i, 'k',  'LineWidth', 1, 'LineStyle' , '-');
xlabel('$\alpha=(1:n)/(n+1)$','Interpreter','latex','FontSize',3+FontSize);
ylabel('$F_{R}^{-1}$','Interpreter','latex','FontSize',3+FontSize);
axis manual
if addtitle
    % {['$' 'n=' num2str(n)  '\mbox{ ; } \; \alpha_0=' num2str(alpha0) '\mbox{ ; } \; p=' num2str(p) '\mbox{ ; } \; \nu=' num2str(nu) '$']}
    title(afig,thetitle,'Interpreter','Latex','FontSize',FontSize);
end

ylim([0 10]);
set(gca,'FontSize',SizeAxesNum);

% plot mcd scatter

hfigMCD = figure;
hold on

v = numel(RAW.loc);

% Plot regular observations (non-outliers) in grey
regular_obs = setdiff(1:size(X,1), RAW.outliers);
scatter(X(regular_obs,1), X(regular_obs,2), 50, [.7 .7 .7], 'filled', 'DisplayName', 'MCD Regular observations');

% Plot the true outliers
scatter(X(Xlabels==1,1), X(Xlabels==1,2), 100, 'r', 'filled', 'DisplayName', 'Contaminants');

% Plot MCD outliers in red
scatter(X(RAW.outliers,1), X(RAW.outliers,2), 50, 'k', 'filled', 'DisplayName', 'MCD Outliers');

% Plot centroid as a black star
scatter(RAW.loc(1), RAW.loc(2), 400, 'b', '*', 'LineWidth', 2, 'DisplayName', 'Estimated Centroid');

% Add the confidence ellipse (97.5%)
% Get the 2x2 covariance matrix for the first two variables
cov_2d = RAW.cov(1:2, 1:2);
% Calculate points for the ellipse
%theintegral = chi2inv(0.975, 2);  % 97.5% confidence level with 2 degrees of freedom
integrand   = @(u) 1 ./ (1 - betainv(u,v/2,nu/2));
theintegral = integral(integrand,0,0.975);

[eigvec, eigval] = eig(cov_2d);
theta = linspace(0, 2*pi, 100);
phi = [cos(theta); sin(theta)];
scaled = sqrt(theintegral) * sqrt(eigval) * phi;
xy = eigvec * scaled + RAW.loc(1:2)' * ones(1,100);
% Plot the ellipse
plot(xy(1,:), xy(2,:), 'k--', 'LineWidth', 1.5, 'DisplayName', 'Confidence Ellipse');

xlimits = xlim; ylimits = ylim; 
maxx = xlimits(2); minx = xlimits(1);
maxy = ylimits(2); miny = ylimits(1);
xlim([minx maxx+0.5]);
ylim([miny maxy+0.5]);

% Add legend
%legend('Location', 'best','Interpreter','latex','FontSize',20);

% Add labels and title
xlabel('$X_1$','Interpreter','latex','FontSize',20);
ylabel('$X_2$','Interpreter','latex','FontSize',20);
%title('MCD Analysis Results');

set(gca,'FontSize',20);

grid off;
box on;
hold off

end

