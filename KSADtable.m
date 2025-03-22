%% Table of Kolmogorov-Smirnov an Anderson-Darling $95\%$ quantiles
% The table KSAD contains the estimated Kolmogorov-Smirnov an Anderson-Darling 
% $95\%$ quantiles. It is available as matlab binary file, csv file and xlsx file. 
% This script reads the data and organise it as a latex table. In the table, the 
% variable $h$ is the actual number of observations used by the MCD based of the 
% trimming level specified by $\alpha_0$.

% load('KSAD.mat');
ksad     = readtable('ksad.xlsx');
ksad_no0 = ksad(ksad.nu ~= 0,:);
precision = 6;
stylerc   = 'b';
[latex_string , disp_string , latex_string_full] = ...
    tabledisp(ksad_no0, precision, stylerc);


%% Display of the matlab annotation table in the paper

% This cell displays a sample of the table in a matlab window. Note that this 
% is possible only for small portions of the full table.

n = size(ksad,1);
ksad_sel  = ksad([1:20 , n-20:n],:);
ksad_sel  = ksad_sel(ksad_sel.nu ~= 0,:);
precision = 6;
stylerc   = 'b';
[latex_string_sel , disp_string_sel , latex_string_full_sel] = ...
    tabledisp(ksad_sel, precision, stylerc);

hf = figure;
annotation(hf,'Textbox','String',latex_string_sel,...
    'FitBoxToText','on','Interpreter','latex',...
    'FontName',get(0,'FixedWidthFontName'),'FontSize',14,...
    'Units','Normalized','Position',[0 0 1 1]);
% This is to display the table in the command window without disp
fprintf(disp_string_sel);



%{
    % This cell is to write the table in a spreadsheet
    filename  = 'ksad_table';
    writetable(ksad,filename);
    writetable(ksad,filename,'FileType','spreadsheet');
%}
