readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Analysis\';

measurement_array = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\measurement*');
conversion_to_micro = 1;
current = 0.1e-6;
% array of all relevant files

for i = 1:numel(measurement_array)
    load(strcat(readlocation,measurement_array(i).name))
    identifying_strings = strsplit(measurement_array(i).name, '_');
    
    figure(1) % retain handle to single figure
    subplot(1,3,i)
    
    plot(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),(conversion_to_micro/current)*eval(strcat(measurement_array(i).name,'(:,6)')))
    
    slope = diff((conversion_to_micro/current)*eval(strcat(measurement_array(i).name,'(:,6)')))./diff(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')));
    threshold_index = numel(slope) - find(slope == min(slope(1:end-2))) + 1;
    
    disp(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(threshold_index,3)')))
    xlabel('Voltage Across Sample (mV)', 'FontSize',14)
    ylabel('Differential Resistance (V/ \mu A)', 'FontSize',14)
    title(strcat(identifying_strings{end},'; Threshold Voltage: ',...
        sprintf('%0.2f',threshold_vals(i)), 'mV'), 'FontSize',14)
    ylim([7 15])
    xlim([0, 6])
    
    threshold_vals = [3.10,2.51,2.45];
    vals = [10.14, 11.26, 9.49];
    
    hold on
    plot(threshold_vals(i),vals(i),'ro')
    hold off
    
    legend('Observations','Minimum Slope','Location','northwest')
end