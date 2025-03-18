function [nu_hat] = paper_Figure_10_test_nu0_algorithm2(...
    n, p, alpha0, nu_true, s, epsilon_true, shift)

% This function is used to generate Figure 10. It is called by function
% Figure10.mlx.

% The function implements Algorithm 2, which is used to estimate the
% correct number of degrees of freedom of the data generating process,
% $\hat{\nu}$. This is done by testing the departures from the bands of
% various $\nu_0$ candidate values. The band that keeps inside the
% empirical radius process, gives the right $\nu$.

% This function was originally called paper_Figure_10_simstudy_Algo2.m

%{
    clear all;
    close all;
    
    rep               = 500;
    n                 = 1000;
    p                 = 5;
    alpha0            = 0.25;

    nu_true           = 5;  
    s                 = [3,5,8,10,20] - nu_true;

    epsilon_true      = 0.10; 

    shift             = 10;
    
[nu_hat] = paper_Figure_10_test_nu0_algorithm2(...
    n, p, alpha0, nu_true, s, epsilon_true, shift)
%}

%% data preparation

% Load the estimated statistics (radius process percentiles)
load('ksad','ksad');

[fit_c05sup,  fit_c05ad] = fit_critical(ksad,p,nu_true);

nu_grid             = nu_true + s;
nu_grid(nu_grid<3)  = [];
nu_grid             = sort(nu_grid,'descend');

% generate contaminated data
[X, ~] = contam_t_normal(n, p, nu_true, epsilon_true, shift);

% compute MCD and take raw covariance matrix,
% not corrected with the consistency factor
RAW = mcd(X,'bdp',alpha0,'smallsamplecor',false,'nsamp',500,'refsteps',10,'plots',0,'msg',0,'nocheck',1);
cfactor0a  = consistencyfactor(alpha0,p);
Sigma_n    = RAW.cov / cfactor0a;
M_n        = RAW.loc;

% set alpha0a_star and n_star
alpha0a_star = (alpha0 - epsilon_true) / (1 - epsilon_true);
n_star       = ceil(n * (1-epsilon_true));

% find the corresponding KS bands
[c05sup,  c05and] = predict_critical(fit_c05sup, fit_c05ad, alpha0a_star, n_star);

% Iterate over the nu values
for nu = nu_grid

    % Compute corrected covariance and non-squared
    % Mahalanobis distances based on alpha0a_star,
    % which is the actual trimming level required for the
    % correction factor in the robust estimate of \Sigma
    cov_star = Sigma_n * consistencyfactor(alpha0a_star, p, nu);
    md       = mahalFS(X, M_n, cov_star);
    d        = sqrt(md);

    % The empirical radius from n_star+1 to n
    empr    = sort(d,'descend');
    empr    = empr(n-n_star+1:n);

    % The theoretical bands for KS test
    alpha = (1:n_star)/(n_star+1);
    r = radiusQuantile((1-alpha),p,nu);
    r = r(:);
    den = radiusDensity(r,p,nu);
    KS_ub = r + (c05sup/sqrt(n_star))./den;
    KS_lb = r - (c05sup/sqrt(n_star))./den;

    % Check the KS and AD exceedences
    KSsum    = sum(or(empr < KS_lb , empr > KS_ub)) ;
    KScheck  = any(or(empr < KS_lb , empr > KS_ub))  ;  %#ok<NASGU>

    AD            = sum(((empr - r) .* den) .^2);
    ADcheck  = AD > c05and;                             %#ok<NASGU>

    % Estimated nu and epsilon
    if KSsum == 0
        nu_hat      = nu;
        tit1 = ['$' '\nu_0=' num2str(nu) '$'];
        tit2 = 'no exceedences found !';
        disp(['found ', num2str(KSsum), ' exceedences: ' 'Estimated nu = ' num2str(nu) ' and epsilon = ' num2str(epsilon_true)]);
    else
        tit1 = ['$' '\nu_0=' num2str(nu)  '\mbox{:} $'];
        tit2 = ['found ', num2str(KSsum), ' exceedences'];
        disp(tit2);
    end


    FontSize    = 20;
    SizeAxesNum = 18;
    grayColor = [.5 .5 .5];

    hfig = figure; afig = gca(hfig);
    plot(alpha,r , 'Color', grayColor , 'LineWidth', 1.5, 'LineStyle' , '--');hold on;
    plot(alpha,empr, 'r', 'LineWidth', 2, 'LineStyle' , '-');
    plot(alpha,r + (c05sup/sqrt(n))./den , 'k', 'LineWidth', 1, 'LineStyle' , '-');
    plot(alpha,r - (c05sup/sqrt(n))./den, 'k',  'LineWidth', 1, 'LineStyle' , '-');
    xlabel('$\alpha=(1:n)/(n+1)$','Interpreter','latex','FontSize',3+FontSize);
    ylabel('$F_{R}^{-1}$','Interpreter','latex','FontSize',3+FontSize);
    axis manual

    title(afig,{[tit1 ' ' tit2]},'Interpreter','Latex','FontSize',FontSize);

    ylim([0 8]);
    set(gca,'FontSize',SizeAxesNum);

    % no need to save results here. Change if needed
    if false
        savein = './Fig10/';
        if ~exist(savein,'dir')
            mkdir(savein);
        end
        figclass = 'algo2';

        combination = ['n' num2str(n)  '_alpha0' num2str(100*alpha0) '_p' num2str(p) '_nu' num2str(nu)];
        saveas(hfig,[savein filesep figclass combination '.fig'],'fig');
        pause(1)
        saveas(hfig,[savein filesep figclass combination '.eps'],'epsc');
        pause(1)
        saveas(hfig,[savein filesep figclass combination '.png'],'png');
    end
end

end

