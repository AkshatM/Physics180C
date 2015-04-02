% A script to collect I vs. V data from Data folder, create plots from them, and
% publish the plots in the Analysis folder.

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Analysis\';

measurement_array = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\measurement*');
% array of all relevant files

DC_resistance = 19.94e3;
to_microamperes = 1e6;
volt_to_millivolt = 1000;

for i = 1:numel(measurement_array)
    identifying_strings = strsplit(measurement_array(i).name, '_');
    load(strcat(readlocation,measurement_array(i).name))
    
    figure(1) % retain handle to single figure
    subplot(1,3,i)
    
    %extrapolated_value = interp1(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(end-2:end,3)')),...
    %    (to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(end-2:end,2)')),...
    %    volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),...
    %    'linear','extrap');
    
    %slope_of_extrapolated_value = diff(extrapolated_value)./diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')));
    slope_of_actual_value = diff((to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(:,2)')))./diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')));
    
    binned_slope = [];
    binned_voltage = [];
    for j = 1:5:numel(slope_of_actual_value)-5
        binned_slope(end + 1) = mean(slope_of_actual_value(j:j+5));
        binned_voltage(end + 1) = volt_to_millivolt*eval(strcat(measurement_array(i).name,'(j + 3,3)'));
    end
    resistance = 1./fliplr(binned_slope);
    binned_voltage = fliplr(binned_voltage);
    %second_derivative_extrap = diff(slope_of_extrapolated_value)./diff(diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)'))));
    second_derivative_actual = diff(resistance)./diff(binned_voltage);
    second_derivative_extrap = diff(diff((to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(:,2)'))))./diff(diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)'))));
    thresh_val =  find(second_derivative_actual == min(second_derivative_actual));
    [mean_value,stdev, min_slope, zscore] = MeanandStd(second_derivative_actual)
    
    plot(binned_voltage, 1000*resistance,'LineWidth',2)
    hold on 
    plot(binned_voltage(thresh_val), 1000*resistance(thresh_val),'ro')
    hold off
    
    xlabel('Voltage Across Sample (mV)', 'FontSize',14)
    ylabel('Binned Resistance (V/\mu A)', 'FontSize',14)
    
    legend('Observations','Threshold Voltage','Location','southwest')
        
    title(strcat(identifying_strings{end},'; Threshold Voltage: ',...
        sprintf('%0.2f',binned_voltage(thresh_val)), 'mV'), 'FontSize',14)
    
end