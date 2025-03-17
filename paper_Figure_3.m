%% This function generates Figure 3

function [outSIM , varargout]= paper_Figure_3(n,p,nu,B,alpha0,data,model,savein)

%{
    % Step 1: simulate radius process for fixed n, p, nu, alpha0

    savein = ['.' filesep 'Fig3' filesep];

    data  = 'T'; 
    model = 'T'; 

    B     = 1000;
    p     = 2;
    nu    = 5;
    n     = 2000; 

    alpha0  = 0.25;  
    [outSIM_a25 , DDs_a25, outPISON_a25, WWS_a25, WWU_a25]= paper_Figure_3(n,p,nu,B,alpha0,data,model,savein);

    alpha0  = 0.50;  
    [outSIM_a50 , DDs_a50, outPISON_a50, WWS_a50, WWU_a50]= paper_Figure_3(n,p,nu,B,alpha0,data,model,savein);

%}

%{
    % Step 2: generate Figure 3 for fixed n, p, nu, alpha0

    savein = ['.' filesep 'Fig3' filesep];
    if ~exist(savein,'dir')
        mkdir(savein);
    end

    % run once for alpha0 = 0.25 and another for 0.50
    alpha0  = 0.25;  
    alpha0  = 0.50;  

    if alpha0 == 0.25
        WS = WWS_a25{1};
        WU = WWU_a25{1};
    elseif alpha0 == 0.50
        WS = WWS_a50{1};
        WU = WWU_a50{1};
    end
    WSvar = var(WS,0,1); WSvar=WSvar(:);
    WUvar = var(WU,0,1); WUvar=WUvar(:);

    % font used in figure axsis
    stdfont = 20;

    %alpha = (n-(1:n)+1) / (n+1);
    alpha = ((1:n)+1) / (n+1);
    alpha = alpha(:);

    K = 20;

    WS = WS(1:K,1,:);
    WS = flipud(squeeze(WS(1:K,:,:)));

    WU = WU(1:K,1,:);
    WU = flipud(squeeze(WU(1:K,:,:)));

    hfig1 = figure; afig1 = gca(hfig1);
    plot(alpha,WS,'Color',[.7 .7 .7]);
    hold on;
    plot(alpha,WSvar,'Color','k','LineWidth',2);
    yline(0,'--k','LineWidth',1.5);
    hold off;
    ylim([-0.4 0.4]);
    set(gca,'FontSize',stdfont);
    xlabel('$\alpha=(1:n)/(n+1)$','Interpreter','latex','FontSize',stdfont);
    ylabel('Radius process with $f_{R}({r_{\alpha}})$ term','Interpreter','latex','FontSize',stdfont);
    if alpha0 == 0.25
        savein1 = [savein 'Fig3a'];
    elseif alpha0 == 0.50;
        savein1 = [savein 'Fig3c'];
    else
        savein1 = [savein 'Fig3_S_alpha0' num2str(alpha0*100)];
    end
    saveas(hfig1, [savein1 '.fig'], 'fig');
    saveas(hfig1, [savein1 '.eps'], 'epsc');
    saveas(hfig1, [savein1 '.png'], 'png');

    hfig2 = figure; afig2 = gca(hfig2);
    plot(alpha,WU,'Color',[.7 .7 .7]);
    hold on;
    plot(alpha,WUvar,'Color','k','LineWidth',2);
    yline(0,'--k','LineWidth',1.5);
    hold off;
    %set(gca, 'XDir','reverse')
    ylim([-10 10]);
    xlabel('$\alpha=(1:n)/(n+1)$','Interpreter','latex','FontSize',stdfont);
    ylabel('Radius process without $f_{R}({r_{\alpha}})$ term','Interpreter','latex','FontSize',stdfont);
    set(gca,'FontSize',stdfont);
    if alpha0 == 0.25
        savein2 = [savein 'Fig3b'];
    elseif alpha0 == 0.50;
        savein2 = [savein 'Fig3d'];
    else
        savein2 = [savein 'Fig3_U_alpha0' num2str(alpha0*100)];
    end
    saveas(hfig2, [savein2 '.fig'], 'fig');
    saveas(hfig2, [savein2 '.eps'], 'epsc');
    saveas(hfig2, [savein2 '.png'], 'png');    

%}

%{
    % generate other figures

    % JASA Fig.3.a
    [hfig31] = radius_plot_c05(outSIM);

    % New radius fig
    [hfig32] = radius_plot_Ca0(outSIM);

    % Plots of JASA figures 2a & 2b
    [hfig33] = radius_plot_jasa2ab(outSIM,DDs);

    % Plots of JASA figures 2 Andrea Cerioli
    [hfig34] = radius_plot_jasa2AC(outSIM,DDs,nu);

    % Plots of bands of Luis Angel
    [hfig35] = radius_plot_c05_bands(outSIM,DDs);

%}


% for replicability
rng(12345);

%% initialisations

% folder where to store result files

if nargin < 8 || isempty(savein)
    savein = 'paper_Figures';
end
if ~exist(savein,'dir')
    mkdir(savein);
end

% Model: Normal ('N') or Student-t ('T')
if nargin < 7 || isempty(model)
    model = 'T';
end

% Data: from the Normal ('N') or Student-t ('T')
if nargin < 6 || isempty(data)
    data = 'T';
end

% trimming level/bdp
if nargin < 5 || isempty(alpha0)
    alpha0 = [0.5,  0.4, 0.3, 0.2, 0.1, 0.05, 0, -1];
end

% number of replicates
if nargin < 4 || isempty(B)
    B = 1000;
end

% REMARK: if the empirical radii comes from a Normal-based estimator
% (e.g. the standard MCD(alpha0)), then nu is not used and we set nu=0
if isequal(model,'N')
    nu=0;
end

if nu==0
    model = 'N';
    data  = 'N';
end


%% Loops

% v and nu are supposed to be fixed
% n and alpha0 can vary depending on the simulation
nvec     = n;
nn       = numel(nvec);
outSIM   = struct;
DDs      = cell(nn,1);
outPISON = struct;
i_n      = 0;

i_n = i_n+1;

% model parameters: depend on n and v
MU = zeros(n,1);
switch model
    case 'T'
        % T
        Sigma = (nu-2)*eye(p,p);
    case 'N'
        % N
        Sigma = eye(p,p);
end

D     = zeros(B,1,n);
Csup  = zeros(B,1);
Cand  = zeros(B,1);

% Scaled and unscaled empirical radius
WS = zeros(B,1,n);
WU = zeros(B,1,n);


if alpha0 > 0
    alpha0a = alpha0;
else
    alpha0a = 0; % no trimming if bdp=0
end

% number of observations to retain/trim (just to display info)
h       = floor(2*floor((n+p+1)/2)-n+2*(n-floor((n+p+1)/2))*(1-alpha0a));
trimmed = n-h;

% compute the radius quantile and the radius density, which are
% used to compute the radius process statistics (sup and Anderson)
alpha = (n-(1:n)+1) / (n+1);
alpha = alpha(:);
r     = radiusQuantile(alpha , p , nu);
r     = r(:);
den   = radiusDensity(r , p , nu);
den   = den(:);

parfor b=1:B % LOOP OVER THE B REPLICATES % parfor

    disp(['rep=' num2str(b) ' - alpha0=' num2str(alpha0a) ' --- n=' num2str(n) ' - trimmed=' num2str(trimmed) ' - h=' num2str(h)]);

    % data sample
    switch data
        case 'T'
            X = randn(n,p) .* (sqrt(nu ./ chi2rnd(nu,n,1)));
        case 'N'
            X = randn(n,p);
    end

    if alpha0a >= 0

        % MCD
        % REMARK: mcd function applies normalisation constant
        %         (consistency factor) at line 1419
        switch model
            case 'T'
                RAW = mcd(X,'modelT',nu,'bdp',alpha0a,'smallsamplecor',false,'nsamp',500,'refsteps',10,'plots',0,'msg',0,'nocheck',1);
            case 'N'
                RAW = mcd(X,            'bdp',alpha0a,'smallsamplecor',false,'nsamp',500,'refsteps',10,'plots',0,'msg',0,'nocheck',1);
        end

        % Mahalanobis distances (NOT reweighted)
        d          = sqrt(RAW.md);
        MCD_loc    = RAW.loc; %#ok<NASGU>
        MCD_cov    = RAW.cov;
        MCD_obj    = RAW.obj;

    else

        % Empirical Mean and Covariance with true model parameters
        % for alpha0 == -1, cfactor is 1 as h=n
        cfactor = consistencyfactor(alpha0a,p,nu);
        d       = sqrt(mahalFS(X,MU,Sigma.*cfactor));
        %{
            % Equivalent to:
            Ytilde = bsxfun(@minus,X, MU);
            d      = sqrt(sum((Ytilde/Sigma).*Ytilde,2));
        %}
        MCD_cov = Sigma.*cfactor;
        MCD_obj = 0;
    end

    % SAVE mahalanobis distances
    D(b,:) = d;

    % sort Mahalanobis distances
    d = sort(d,'ascend');

    % the empirical radius
    emp_r = d(n-(1:n)+1);

    % SAVE radius processes
    W = sqrt(n) * (den  .* abs(emp_r - r));
    Csup(b,1) = max(W);
    Cand(b,1) = sum(((emp_r - r) .* den) .^2);

    % scaled and unscaled empirical radius
    WS(b,1,:) = sqrt(n) * (den  .* (emp_r - r));
    WU(b,1,:) = sqrt(n) * (emp_r - r);

    % save covariances for Pison
    outPISON(i_n,1,b).cov = MCD_cov;
    outPISON(i_n,1,b).obj = MCD_obj;

end

% The n sorted Mahalanobis distances
Ds = sort(D,3);


% The sorted Mahalanobis distances
DDs{i_n} = Ds;

% The B sorted Radius Process values
CsupS = sort(Csup,1);
CandS = sort(Cand,1);

WWS{i_n} = WS;
WWU{i_n} = WU;



%% output structure

outSIM(i_n,1).n        = n;
outSIM(i_n,1).v        = p;
outSIM(i_n,1).nu       = nu;
outSIM(i_n,1).B        = B;
outSIM(i_n,1).alpha0   = alpha0;
outSIM(i_n,1).Csup     = CsupS;
outSIM(i_n,1).Cand     = CandS;
outSIM(i_n,1).c05sup   = CsupS(floor(0.95*B),:);
outSIM(i_n,1).c05and   = CandS(floor(0.95*B),:);

outSIM(i_n,1).model    = model;
outSIM(i_n,1).data     = data;

% outSIMi   = outSIM(i_n);
% outPISONi = outPISON(i_n);

% % SAVE INTERMEDIATE RESULTS
% save([savein 'I_outSIM_n',  num2str(n),'_v',num2str(v),'_nu',num2str(nu)],'outSIMi');
% save([savein 'I_outPISON_n',num2str(n),'_v',num2str(v),'_nu',num2str(nu)],'outPISONi');


% % SAVE THE FULL RESULTS
% save([savein 'F_outSIM_v',num2str(v),'_nu',num2str(nu)],'outSIM');
% save([savein 'F_DDs_v',num2str(v),'_nu',num2str(nu)],'DDs');
% save([savein 'F_outPISON_v',num2str(v),'_nu',num2str(nu)],'outPISON');

% return the Mahalanobis distances in the optional argument
varargout{1} = DDs;
varargout{2} = outPISON;
varargout{3} = WWS;
varargout{4} = WWU;

end


