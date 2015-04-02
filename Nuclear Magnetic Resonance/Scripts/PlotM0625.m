% This script plots the retrieved data.

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\';

load(strcat(rootdir, 'M0625channel1data.mat'));
load(strcat(rootdir, 'M0625channel2data.mat'));

figure()

%modelfun1 = @(a,x)(a(1)*(exp((-x/a(2)))));
%plot(1e-3*(ch1_intensity(2:end)),sqrt(ch1_value(2:end).^2+ch2_value(2:end).^2),'ro', 'MarkerSize', 5)
plot(1e-3*(ch1_intensity(2:end)),ch1_value(2:end),'ro', 'MarkerSize', 5)
%[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(1e-3*(ch1_intensity(2:end)),sqrt(ch1_value(2:end).^2+ch2_value(2:end).^2),modelfun1,[1.45, 2]);
%hold on
%plot(1e-3*(ch1_intensity),modelfun1(beta,1e-3*(ch1_intensity)))
% hold on 
% hy = graph2d.constantline(mean(ch1_value), 'Color',[.7 .7 .7]);
% changedependvar(hy,'y');
title('RMS Values of Spin Echo', 'FontSize', 12)
xlabel('Time Delay (s)', 'FontSize', 12)
ylabel('Signal Height (T)', 'FontSize', 12)
% xlim([0 1.5])
%legend('Original Data', sprintf('Nonlinear Fit'), 'Location', 'southeast')
%hold off