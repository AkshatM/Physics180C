% This script plots the retrieved data.

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\';

load(strcat(rootdir, 'spinflipchannel1data.mat'));
load(strcat(rootdir, 'spinflipchannel2data.mat'));

figure()

plot(1e-2*(ch1_intensity),ch1_value,'ro', 'MarkerSize', 5)
hold on 
hy = graph2d.constantline(mean(ch1_value), 'Color',[.7 .7 .7]);
changedependvar(hy,'y');
title('Channel 1', 'FontSize', 12)
xlabel('Pulse Duration (ms)', 'FontSize', 12)
ylabel('Signal Height (T)', 'FontSize', 12)
xlim([0 1.5])
legend('Data Points', 'Average Value', 'Location', 'northeast')
hold off

figure()

plot(1e-2*(ch2_intensity),ch2_value,'ro', 'MarkerSize', 5)
hold on 
hy = graph2d.constantline(mean(ch2_value), 'Color',[.7 .7 .7]);
changedependvar(hy,'y');
title('Channel 2', 'FontSize', 12)
xlabel('Pulse Duration (ms)', 'FontSize', 12)
ylabel('Signal Height (T)', 'FontSize', 12)
xlim([0 1.5])
legend('Data Points', 'Average Value', 'Location', 'northwest')
hold off