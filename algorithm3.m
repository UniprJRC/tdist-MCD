function [epsilon_hat, nu_hat, outliers, TPR, FPR, FNR] = algorithm3(X, Xlabels, alpha0)

% This is Algorithm 3. It is used to estimate $\nu$ and $\epsilon$.

%{
    clear all;
    close all;
    
    ds_path = './real_datasets';

    dsfile0 = 'Grass_original.prn';
    dsfile1 = 'Grass_contaminated.prn';
    dsfile1b = 'Grass_original_contaminated.prn';

    dsfile2 = 'Returns_1991_1992_CanUK_contaminated.prn';
    
    dsfile = [ds_path filesep dsfile0];
    X0     = load(dsfile);
    n0     = size(X0,1);
    Xlabels0  = [];
    %Xlabels0 = zeros(n1,1);
    %Xlabels0(n1-30+1:end) = 1;
    alpha00 = round((30/n0)*1.3 , 3);
    alpha00 = 0.25;
    [Grass_ori_epsilon_hat, Grass_ori_nu_hat, Grass_ori_outliers, ...
        Grass_ori_TPR, Grass_ori_FPR, Grass_ori_FNR] = algo3(X0,Xlabels0,alpha00);
    out0 = [ds_path filesep 'outliers_Grass_ori_nu_' num2str(Grass_ori_nu_hat) '_epsilon_' num2str(Grass_ori_epsilon_hat*100)];
    csvwrite([out0 '.txt'], Grass_ori_outliers);

    dsfile = [ds_path filesep dsfile1b];
    X1b     = load(dsfile);
    %X1     = X1(1:300,:);
    n1b     = size(X1b,1);
    Xlabels1b = zeros(n1b,1);
    Xlabels1b(n1b-30+1:end) = 1;
    alpha01b = round((30/n1b)*1.3 , 3);
    alpha01b = 0.25;
    [Grassb_epsilon_hat, Grassb_nu_hat, Grassb_outliers, ...
        Grassb_TPR, Grassb_FPR, Grassb_FNR] = algo3(X1b,Xlabels1b,alpha01b);
    out1b = [ds_path filesep 'outliers_Grassb_nu_' num2str(Grassb_nu_hat) '_epsilon_' num2str(Grassb_epsilon_hat*100)];
    csvwrite([out1b '.txt'], Grassb_outliers);


    dsfile = [ds_path filesep dsfile1];
    X1     = load(dsfile);
    %X1     = X1(1:300,:);
    n1     = size(X1,1);
    Xlabels1 = zeros(n1,1);
    Xlabels1(n1-30+1:end) = 1;
    alpha01 = round((30/n1)*1.3 , 3);
    alpha01 = 0.25;
    [Grass_epsilon_hat, Grass_nu_hat, Grass_outliers, ...
        Grass_TPR, Grass_FPR, Grass_FNR] = algo3(X1,Xlabels1,alpha01);
    out1 = [ds_path filesep 'outliers_Grass_nu_' num2str(Grass_nu_hat) '_epsilon_' num2str(Grass_epsilon_hat*100)];
    csvwrite([out1 '.txt'], Grass_outliers);

    dsfile = [ds_path filesep dsfile2];
    X2     = load(dsfile);
    n2     = size(X2,1);
    Xlabels2 = zeros(n2,1);
    Xlabels2(n2-60+1:end) = 1;
    alpha02 = round((60/n2)*1.3 , 3);
    alpha02 = 0.25; %0.25
    [Returns_epsilon_hat, Returns_nu_hat, Returns_outliers, ...
     Returns_TPR, Returns_FPR, Returns_FNR] = algo3(X2,Xlabels2,alpha02);
    out2 = [ds_path filesep 'outliers_Returns_nu_' num2str(Returns_nu_hat) '_epsilon_' num2str(Returns_epsilon_hat*100)];
    csvwrite([out2 '.txt'], Returns_outliers);    


    outliers0 = zeros(size(X0,1),1); 
    outliers0(Grass_ori_outliers,1) = 1;
    figure;
    [H0,AX0,BigAx0] = spmplot(X0,'group', outliers0,'dispopt','box','tag','Grass_ori');
    sgtitle('Grass original contaminated','FontSize',18,'Interpreter','Latex');
    set(AX0,'FontSize',16);
    saveas(BigAx0,[ds_path filesep 'grass_ori.fig'],'fig');
    saveas(BigAx0,[ds_path filesep 'grass_ori.eps'],'epsc');


    outliers1b = zeros(size(X1b,1),1); 
    outliers1b(Grassb_outliers,1) = 1;
    figure;
    [H1b,AX1b,BigAx1b] = spmplot(X1b,'group', outliers1b,'dispopt','box','tag','Grassb');
    sgtitle('Grassb contaminated','FontSize',18,'Interpreter','Latex');
    set(AX1b,'FontSize',16);
    saveas(BigAx1b,[ds_path filesep 'grassb.fig'],'fig');
    saveas(BigAx1b,[ds_path filesep 'grassb.eps'],'epsc');

    outliers1 = zeros(size(X1,1),1); 
    outliers1(Grass_outliers,1) = 1;
    figure;
    [H1,AX1,BigAx1] = spmplot(X1,'group', outliers1,'dispopt','box','tag','Grass');
    sgtitle('Grass contaminated','FontSize',18,'Interpreter','Latex');
    set(AX1,'FontSize',16);
    saveas(BigAx1,[ds_path filesep 'grass.fig'],'fig');
    saveas(BigAx1,[ds_path filesep 'grass.eps'],'epsc');

    outliers2 = zeros(size(X2,1),1); 
    outliers2(Returns_outliers) = 1;
    figure;
    [H2,AX2,BigAx2] = spmplot(X2,'group', outliers2,'dispopt','box','tag','Returns');
    sgtitle('Returns 1991-1992 contaminated','FontSize',18,'Interpreter','Latex');
    set(AX2,'FontSize',16);
    saveas(BigAx2,[ds_path filesep 'returns.fig'],'fig');
    saveas(BigAx2,[ds_path filesep 'returns.eps'],'epsc');

    disp(['Grass: nu = ' num2str(Grass_nu_hat) ' ; epsilon = ' num2str(Grass_epsilon_hat)]);
    disp(['   TPR: ' num2str(Grass_TPR)]);
    disp(['   FPR: ' num2str(Grass_FPR)]);
    disp(['   FNR: ' num2str(Grass_FNR)]);

    disp(['Returns: nu = ' num2str(Returns_nu_hat) ' ; epsilon = ' num2str(Returns_epsilon_hat)]);
    disp(['   TPR: ' num2str(Returns_TPR)]);
    disp(['   FPR: ' num2str(Returns_FPR)]);
    disp(['   FNR: ' num2str(Returns_FNR)]);
%}


%% data preparation

outliers    = nan;
TPR         = nan;
FPR         = nan;
FNR         = nan;

if nargin < 3 || isempty(alpha0)
    alpha0 = 0.25;
end

if nargin < 2
    Xlabels = [];
end

% Load the estimated statistics
load('ksad','ksad');

% Load the dataset
[n,p] = size(X);

% set the epsilon grid, with epsilon < alpha0a
epsilon_grid_step  = 1/n;
epsilon_grid       = 0:epsilon_grid_step:alpha0;
numel_epsilon_grid = numel(epsilon_grid);

% set the nu grid, with nu > 2
nu_grid             = [0 3:10 15 20 30 40 50] ;
numel_nu            = numel(nu_grid);

% compute MCD and take raw covariance matrix,
% not corrected with the consistency factor
RAW = mcd(X,'bdp',alpha0,'smallsamplecor',false,'nsamp',500,'refsteps',10,'plots',0,'msg',0,'nocheck',1);
cfactor0a  = consistencyfactor(alpha0,p);
Sigma_n    = RAW.cov / cfactor0a;
M_n        = RAW.loc;

% Initialize an exit flag
exitFlag    = false;
epsilon_hat = [];
nu_hat      = [];
% Outer while loop: Iterate over epsilon grid
i_epsilon = 0;
while ~exitFlag && i_epsilon<numel_epsilon_grid
    i_epsilon = i_epsilon+1;
    epsilon   = epsilon_grid(i_epsilon);

    % set alpha0a_star and n_star
    alpha0a_star = (alpha0 - epsilon) / (1 - epsilon);
    n_star       = ceil(n * (1-epsilon));


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

        % find the KS bands
        [fit_c05sup,  fit_c05ad] = fit_critical(ksad,p,nu);
        [c05sup_i,  c05and_i]    = predict_critical(fit_c05sup, fit_c05ad, alpha0a_star, n_star);

        KS_ub_i = r + (c05sup_i/sqrt(n_star))./den;
        KS_lb_i = r - (c05sup_i/sqrt(n_star))./den;

        % Check the KS and AD excedences
        KSsum_i    = sum(or(emp_r < KS_lb_i , emp_r > KS_ub_i)) ;
        KScheck_i  = any(or(emp_r < KS_lb_i , emp_r > KS_ub_i))  ; %#ok<NASGU>

        AD         = sum(((emp_r - r) .* den) .^2);
        ADcheck_i  = AD > c05and_i; %#ok<NASGU>

        % Estimated nu and epsilon
        if KSsum_i == 0  % choose KSsum_i or ADcheck_i
            epsilon_hat = epsilon;
            nu_hat      = nu;

            % set exitFlag to true and break
            exitFlag = true;

            disp(['Found ', num2str(KSsum_i), ' exceedences: ' 'Estimated nu = ' num2str(nu) ' and epsilon = ' num2str(epsilon)]);
            
            C = 0.99; % 1 - 0.05/n
            outliers = find(d > radiusQuantile(C,p,nu));
            if ~isempty(Xlabels)
                [TPR, FPR, FNR] = compute_outlier_detection_metrics(outliers, Xlabels);
            end

        else
            % do nothing: the structures are initialised to nan
            %disp(['Found ', num2str(KSsum_i), ' excedences']);
        end

        % THIS IS TO CHECK CONVERGENCE ISSUES
        % DEBUG ONLY: DOES NOT WORK WITH PARFOR
        if false
                disp(['nu=' num2str(nu) ' -- epsilon=' num2str(epsilon) ]); %#ok<UNRCH>
                radius_c05_bands(r, emp_r, KS_ub_i, KS_lb_i, alpha0, nu, X, Xlabels, RAW);
        end

        % if exitFlag=true break also the nu grid loop
        % if exitFlag
        %    break;
        % end

    end % s

end % epsilon

radius_c05_bands(r, emp_r, KS_ub_i, KS_lb_i, alpha0, nu, X, Xlabels, RAW);

end


%% plot bands and mcd scatter

function [hfigBands , hfigMCD] = radius_c05_bands(r, emp_r, KS_ub_i, KS_lb_i, alpha0, nu, X, Xlabels, RAW)

addtitle = true;
n = size(r,1);
p = numel(RAW.loc);
alpha = (1:n)/(n+1);

thetitle = {['$' 'n^{*}=' num2str(n)  '\mbox{ ; } \; \alpha_0=' num2str(alpha0) '\mbox{ ; } \; p=' num2str(p) '\mbox{ ; } \; \nu=' num2str(nu) '$']};

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

p = numel(RAW.loc);

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
integrand   = @(u) 1 ./ (1 - betainv(u,p/2,nu/2));
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

