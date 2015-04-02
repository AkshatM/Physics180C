% A script to collect I vs. V data from Data folder, create plots from them, and
% publish the plots in the Analysis folder.

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Analysis\';

measurement_array = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\measurement*');
% array of all relevant files

DC_resistance = 19.94e3;
to_microamperes = 1e6;
volt_to_millivolt = 1000;
conversion_to_micro = 1;
current = 0.1e-6;

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
    
    binned_AC = [];
    binned_voltage = [];
    for j = 2:5:numel((conversion_to_micro/current)*eval(strcat(measurement_array(i).name,'(:,6)')))-5
        binned_AC(end + 1) = mean((conversion_to_micro/current)*eval(strcat(measurement_array(i).name,'(j:j+5,6)')));
        binned_voltage(end + 1) = volt_to_millivolt*eval(strcat(measurement_array(i).name,'(j + 3,3)'));
    end
    resistance = fliplr(binned_AC);
    binned_voltage = fliplr(binned_voltage);
    
    slope = diff(resistance)./diff(binned_voltage);
    thresh_val = find(slope == min(slope));
    
    [mean_value,stdev, min_slope, zscore] = MeanandStd(slope)
    
    plot(binned_voltage, resistance,'LineWidth',2)
    hold on 
    plot(binned_voltage(thresh_val), resistance(thresh_val),'ro')
    hold off
    
    xlabel('Voltage Across Sample (mV)', 'FontSize',14)
    ylabel('Binned Resistance (V/\mu A)', 'FontSize',14)
    ylim([7 15])
    xlim([0, 6])
        
    title(strcat(identifying_strings{end},'; Threshold Voltage: ',...
        sprintf('%0.2f',binned_voltage(thresh_val)), 'mV'), 'FontSize',14)
end