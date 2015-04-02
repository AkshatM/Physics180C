% A script to collect tempsweep data from Data folder, create plots from them, and
% publish the plots in the Analysis folder.

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Analysis\';

reg_current = 5e-6;
first_current = 1e-7;
temperature_array = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\tempsweep*');
% array of all relevant files

for i = 1:numel(temperature_array)
    load(strcat(readlocation,temperature_array(i).name))
     figure(1) % retain handle to single figure
     subplot(1,3,i)
     if i > 1
        plot(eval(strcat(temperature_array(i).name,'(:,3)')),(1/reg_current)*eval(strcat(temperature_array(i).name,'(:,2)')))
        title(['Run ',num2str(i), '; Current: 5 \mu A'], 'FontSize',14)
     else
        plot(eval(strcat(temperature_array(i).name,'(:,3)')),(1/first_current)*eval(strcat(temperature_array(i).name,'(:,2)')))
        title(['Run ',num2str(i), '; Current: 0.1 \mu A'], 'FontSize',14)
     end
     xlabel('Temperature (K)', 'FontSize',14)
     ylabel('Resistance (\Omega)', 'FontSize',14)
end

