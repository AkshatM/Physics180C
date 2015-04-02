% This script plots the retrieved data.

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\';

load(strcat(rootdir, 'T1channel1data.mat'));
load(strcat(rootdir, 'T1channel2data.mat'));
load(strcat(rootdir, 'T1medianchannel1data.mat'));
load(strcat(rootdir, 'T1medianchannel2data.mat'));

figure()

modelfun1 = @(a,x)(a(1)*(1 - 2*exp((-x/a(2)))));
plot(1e-3*(ch1_intensity(2:end)),ch1_value(2:end),'ro', 'MarkerSize', 5)
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(1e-3*(ch1_intensity),ch1_value,modelfun1,[1.227, 9.125]);
hold on
%plot(1e-3*(ch1_intensity_m(2:end)),ch1_value_m(2:end),'bx', 'MarkerSize', 12)
plot(1e-3*(ch1_intensity),modelfun1(beta,1e-3*(ch1_intensity)))
% hold on 
% hy = graph2d.constantline(mean(ch1_value), 'Color',[.7 .7 .7]);
% changedependvar(hy,'y');
title('Channel 1', 'FontSize', 12)
xlabel('Time Delay (s)', 'FontSize', 12)
ylabel('Signal Height (T)', 'FontSize', 12)
% xlim([0 1.5])
%legend('Original Data (Collected with Mean)', sprintf('Original Data (Collected with Median)'), 'Location', 'southeast')
hold off