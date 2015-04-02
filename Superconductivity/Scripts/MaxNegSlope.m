function [index] = MaxNegSlope(input_data)
%MaxNegSlope Finds point where minimum negative slope occurs
%   This function finds the index where the maximum negative slope occurs
%   in our provided data set. The input_data is always of the form m x 3, 
%   where m is some integer. The first column represents the voltage; the
%   second column represents the frequency; the third column represents the
%   temperature.

% We flip the data first, so that diff operates in the correct direction
% i.e. from lower voltage to higher voltage.

flipped_value = flipud(input_data(:,2));
constant_voltage_difference = input_data(1,1) - input_data(2,1);

differences = flipud((1/(constant_voltage_difference*0.3*1699))*(flipped_value(2:end,1) - flipped_value(1:end-1,1)));
% computing the slope with respect to the field, not the voltage!

slope = min(differences(:,1));
index = find(differences(:,1) == slope) + 1;
% because differences has one less element than input(:,2), and we want to
% map index to the value at which the negative slope starts in the input
% data. 

end

