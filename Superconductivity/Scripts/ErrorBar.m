function [errorbar] = ErrorBar(input_data, critical_field_index)
%ERRORBARS Computes error bars of critical field measurements
%   It finds the distribution of negative slopes, calculates the mean and
%   standard deviation of all negative slopes except the minimum one, 

flipped_value = flipud(input_data(:,2));
constant_voltage_difference = input_data(1,1) - input_data(2,1);

differences = flipud((1/(constant_voltage_difference*0.3*1699))*...
    (flipped_value(2:end,1) - flipped_value(1:end-1,1))); %calculates slopes of all indices 

stdev_of_neg_slopes = std(differences); %experimenting with the idea of taking all slopes, not just negative ones.

%stdev_of_neg_slopes = std(differences(differences < 0)); % find standard deviation of all negative slopes

range = [differences(critical_field_index - 1) - stdev_of_neg_slopes, differences(critical_field_index - 1) + stdev_of_neg_slopes];

find_freqs_index = find(differences > range(1) & differences < range(2) & differences ~= min(differences)) + 1; %finds indices of all the frequencies within our range

if isempty(find_freqs_index)
    errorbar = 0;
else
    errorbar = 1699*0.3*(std(input_data(find_freqs_index,1))/2);
end

end

