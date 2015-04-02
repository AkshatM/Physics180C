% A script to collect dV/dI vs. V data from Data folder, create plots from them, and
% publish the plots in the Analysis folder.

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Analysis\';

measurement_array = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\measurement*');
conversion_to_micro = 1;
current = 0.1e-6;
volt_to_millivolt = 1000;
DC_resistance = 19.94e3;
to_microamperes = 1e6;
% array of all relevant files

for i = 1:numel(measurement_array)
    load(strcat(readlocation,measurement_array(i).name))
    identifying_strings = strsplit(measurement_array(i).name, '_');
    
    figure(1) % retain handle to single figure
    subplot(1,3,i)
    
    dIdV = 1./(eval(strcat(measurement_array(i).name,'(:,6)')));
    
    val = dIdV.*(eval(strcat(measurement_array(i).name,'(:,3)')));
    
    plot(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),val/10)
    hold on
    plot(volt_to_millivolt*eval(strcat(measurement_array(i).name,'(:,3)')),...
        (to_microamperes/(DC_resistance))*eval(strcat(measurement_array(i).name,'(:,2)')),'r','LineWidth',2)
    ylim([0 700])
    xlim([0, 6])
    xlabel('Voltage Across Sample (mV)', 'FontSize',14)
    ylabel('DC Current (\mu A)', 'FontSize',14)
    title(identifying_strings{end}, 'FontSize',14)
    legend('Reconstructed Current', 'DC Current','Location','northwest')
    hold off
end