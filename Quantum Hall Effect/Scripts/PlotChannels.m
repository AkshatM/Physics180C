% A script to read and collect data from readlocation

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Quantum Hall Effect\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Quantum Hall Effect\Analysis\';

directory = dir(strcat(readlocation,'*.mat'));

temp_array = {'2 K', '4 K', '7 K'}; 

for i = 1:numel(directory)
    load(strcat(readlocation,directory(i).name))
    filename = strsplit(directory(i).name, '.');
    data = eval(strcat(filename{1},'.data'));
    
    figure(1) % retain handle to single figure
    subplot(3,3,i)
    plot(1e-4*data(:,3),1e-3*data(:,4),'-*', 'MarkerSize',4)
    hold on
    plot(1e-4*data(2:2:end,3),1e-3*data(2:2:end,4),'-k', 'MarkerSize',2)
    legend('Data','Location','northwest')
    hold off
    xlabel('Magnetic Field (T)','FontSize',12)
    ylabel('Resistivity (\Omega m)', 'FontSize',12)
    xlim([0 9])
    ylim([0 7])
    set(gca,'XTick',0:9)
    title(strcat('Longitudinal Resistivity; ', temp_array{i}), 'FontSize',12)
    subplot(3,3,i+3)
    plot(1e-4*data(:,3),3e-3*data(:,17),'-*', 'MarkerSize',4)
    hold on
    hy = graph2d.constantline(38.7415,'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hy,'y');
    hy = graph2d.constantline(25.827,'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hy,'y');
    hy = graph2d.constantline(19.37075,'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hy,'y');
    hy = graph2d.constantline(15.4966,'LineStyle',':', 'Color',[.7 .7 .7]);
    changedependvar(hy,'y');
    plot(1e-4*data(3:2:end,3),3e-3*data(3:2:end,17),'-k', 'MarkerSize',2)
    legend('Data','Plateau Values','Location','northwest')
    hold off
    xlabel('Magnetic Field (T)', 'FontSize',12)
    ylabel('Resistivity (\Omega m)','FontSize',12)
    xlim([0 9])
    set(gca,'XTick',0:9)
    title(strcat('Transverse Resistivity; ', temp_array{i}), 'FontSize',12)
    subplot(3,3,i+6)
    plot(1e-4*data(:,3),(100e-6).*(data(:,17)),'-*', 'MarkerSize',4)
    hold on
    plot(1e-4*data(3:2:end,3),(100e-6).*data(3:2:end,17),'-k', 'MarkerSize',2)
    legend('Data','Location','northwest')
    hold off
    xlabel('Magnetic Field (T)','FontSize',12)
    ylabel('Voltage (mV)','FontSize',12)
    xlim([0 9])
    %ylim([0 0.05])
    set(gca,'XTick',0:9)
    %set(gca,'YTick',0:0.01:0.05)
    title(strcat('Hall Voltage; ', temp_array{i}), 'FontSize',12)
end



