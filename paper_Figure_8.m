%% This function generates Figure 8

function [hfig] = paper_Figure_8(outSIM,emp_r,figclass,addtitle)

%{
    % first, simulate radius process for fixed n, p, nu, alpha0, 
    % as in function paper_Figure_3

    data    = 'T'; 
    model   = 'T'; 
    B       = 1000;
    p       = 5;
    nu      = 5;  % 5 3 10
    alpha0  = 0.25;
    n       = [1000]; 
    addtitle = false;

    [outSIM , DDs]= paper_Figure_3(n,p,nu,B,alpha0,data,model)
    outSIM_nu5 = outSIM;
    DDs_nu5    = DDs;
    
    nu      = 3;  
    [outSIM , DDs]= paper_Figure_3(n,p,nu,B,alpha0,data,model)
    outSIM_nu3 = outSIM;
    DDs_nu3    = DDs;

    nu      = 10;  
    [outSIM , DDs]= paper_Figure_3(n,p,nu,B,alpha0,data,model)
    outSIM_nu10 = outSIM;
    DDs_nu10    = DDs;

    
    [hfig] = paper_Figure_8(outSIM_nu5, DDs_nu5,  'paper_8a_');

    [hfig] = paper_Figure_8(outSIM_nu5, DDs_nu3,  'paper_8b_');
    
    [hfig] = paper_Figure_8(outSIM_nu5, DDs_nu10, 'paper_8c_');   
    
%}

if nargin<4 || isempty(addtitle)
    addtitle = false;
end

if nargin<3 || isempty(figclass)
    figclass = 'figure';
end

if ~exist('Fig8','dir')
    mkdir('Fig8');
end
figdir = ['.' filesep 'Fig8'];

FontSize    = 20;
SizeAxesNum = 18;
grayColor = [.5 .5 .5];

N       = [outSIM.n];
Csup    = [outSIM.Csup];
Cand    = [outSIM.Cand];
B       = outSIM.B;
alpha0  = outSIM.alpha0;
p       = outSIM.p;
nu      = outSIM.nu;
c05sup  = [outSIM.c05sup];
c05and  = [outSIM.c05and];

nbdp    = numel(alpha0);

nn   = numel(N);

i_n     = 0;
for in=1:nn  
    i_n = i_n+1;
    n   = N(in);

    % alpha
    alpha = (1:n)/(n+1);
    % eta
    eta = 1 / consistencyfactor(1-alpha0,p,nu);
    % radius
    r = radiusQuantile(1-alpha,p,nu);
    % density
    den = radiusDensity(r,p,nu);

    % take as an example K realizations  (from the first)
    K = 1;
    empr = emp_r(i_n);
    empr = empr{1,1,:};
    empr = flipud(squeeze(empr(1:K,:,:)));

    alpha = alpha(:);
    r = r(:);
    if K>1
        empr = sort(empr,2,'descend');
    else
        empr = empr(:);
    end
    den = den(:);

    hfig = figure; afig = gca(hfig);
    plot(alpha,r , 'Color', grayColor , 'LineWidth', 1.5, 'LineStyle' , '--');hold on;
    plot(alpha,empr, 'r', 'LineWidth', 2, 'LineStyle' , '-');
    plot(alpha,r + (c05sup(i_n)/sqrt(n))./den , 'k', 'LineWidth', 1, 'LineStyle' , '-');
    plot(alpha,r - (c05sup(i_n)/sqrt(n))./den, 'k',  'LineWidth', 1, 'LineStyle' , '-');
    xlabel('$\alpha=(1:n)/(n+1)$','Interpreter','latex','FontSize',3+FontSize);
    ylabel('$F_{R}^{-1}$','Interpreter','latex','FontSize',3+FontSize);
    axis manual
    if addtitle
        title(afig,{['$' 'n=' num2str(n)  '\mbox{ ; } \; \alpha_0=' num2str(alpha0) '\mbox{ ; } \; p=' num2str(p) '\mbox{ ; } \; \nu=' num2str(nu) '$']},'Interpreter','Latex','FontSize',FontSize);
    end

    ylim([0 10]);
    set(gca,'FontSize',SizeAxesNum);

    combination = ['n' num2str(n)  '_alpha0' num2str(100*alpha0) '_p' num2str(p) '_nu' num2str(nu)];
    saveas(hfig,[figdir filesep figclass combination '.fig'],'fig');
    pause(1)
    saveas(hfig,[figdir filesep figclass combination '.eps'],'epsc');
    pause(1)
    saveas(hfig,[figdir filesep figclass combination '.png'],'png');

end

end
