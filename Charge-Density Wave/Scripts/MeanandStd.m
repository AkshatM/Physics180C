function [mean_value,stdev, min_slope, zscore] = MeanandStd(slope)
%MeanandStd Calculates the mean, stdandard deviation and minimum slope from
% slope.

min_slope = slope(slope == min(slope(1:end-2)));

stdev = std(slope);

mean_value = mean(slope);

zscore = (mean_value - min_slope)/(stdev);
end

