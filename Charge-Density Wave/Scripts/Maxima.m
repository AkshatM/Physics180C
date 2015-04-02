function [result, peaks] = Maxima(data, k)
%Maxima: Finds the first k maximum peak values in data. Data is assumed to be a
%single row.

length_of_data = size(data);

if length_of_data(1) ~= 1
   data = transpose(data);
end

clearvars length_of_data

peaks = findpeaks(data);

sorted_peaks = sort(peaks);

result = sorted_peaks(end-k+1:end);

end

