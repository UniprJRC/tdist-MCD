function [TPR,FPR,FNR] = compute_outlier_detection_metrics(outliers, Xlabels)
% Inputs:
%   outliers - indices of detected outliers (e.g. by the MCD)
%   Xlabels  - ground truth binary labels (1 = outlier, 0 = inlier)
%
% Outputs:
%   metrics - a structure containing TPR, FPR, FNR as percentages

% Total inliers and true outliers in the ground truth
totalInliers = length(Xlabels) - sum(Xlabels);
totalTrueOutliers = sum(Xlabels);

% Compute TP, FP, and FN
trueOutliers = find(Xlabels == 1);
[~, matchIndices] = ismember(outliers, trueOutliers);
TP = sum(matchIndices > 0); % True Positives
FP = sum(matchIndices == 0); % False Positives
[~, matchIndices] = ismember(trueOutliers, outliers);
FN = sum(matchIndices == 0); % False Negatives

% Compute metrics
TPR = (TP / totalTrueOutliers); % True Positive Rate
FPR = (FP / totalInliers);      % False Positive Rate
FNR = (FN / totalTrueOutliers); % False Negative Rate
end

