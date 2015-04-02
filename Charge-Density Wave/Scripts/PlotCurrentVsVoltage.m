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
    
    extrapolated_value = interp1(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(end-2:end,3)')),...
        (to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(end-2:end,2)')),...
        volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),...
        'linear','extrap');
    
    slope_of_extrapolated_value = diff(extrapolated_value)./diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')));
    slope_of_actual_value = diff((to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(:,2)')))./diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')));
    
    second_derivative_extrap = diff(slope_of_extrapolated_value)./diff(diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)'))));
    second_derivative_actual = diff(slope_of_actual_value)./diff(diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)'))));
    
    
    %voit = [slope_of_extrapolated_value, slope_of_actual_value];
    
    %for j = 1:numel(extrapolated_value) - 1
    %    if slope_of_actual_value(end - j,1) - slope_of_extrapolated_value(end - j,1) >= 2.5
    %    %if (to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(end - j,2)')) - extrapolated_value(end - j,1) >= 1
    %        threshold_index_value = j;
    %        break
    %    end
    %end
    
    [mean_value,stdev, min_slope, zscore] = MeanandStd(second_derivative_actual)
    
    
    threshold_voltages = [2.60, 2.28, 3.45];
    vals = [210.6, 185.6, 357.7];
    
    plot(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),...
        (to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(:,2)')),'LineWidth',2)
    
    hold on
    
    plot(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),extrapolated_value,'-r.','LineWidth',0.1)
    
    plot(threshold_voltages(i),vals(i),'ko','LineWidth',2)
    
    hold off
    
    xlabel('Voltage Across Sample (mV)', 'FontSize',14)
    ylabel('DC Current (\mu A)', 'FontSize',14)
    legend('Observations','Ohmic Behaviour','Threshold Voltage','Location','northwest')
    
    title(strcat(identifying_strings{end},'; Threshold Voltage: ',...
        sprintf('%0.2f',threshold_voltages(i)), 'mV'), 'FontSize',14)
end