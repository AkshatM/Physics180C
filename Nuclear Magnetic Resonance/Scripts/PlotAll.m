rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\';

datanames = {'M25', 'M125', 'M0625', 'M03125'};
init = [0.6979, 0.9167, 0.3027, 0.7697];
T1 = [1.59668530789117,0.531592057625686,0, 0.010];
modelfun1 = @(a,x)(a(1)*(1 - 2*exp((-x/a(2)))) + a(3));

for i = 1:numel(datanames)
    load(strcat(rootdir, strcat(datanames{i},'channel1data.mat')));
    load(strcat(rootdir, strcat(datanames{i},'channel2data.mat')));
    subplot(2,2,i)
    plot(1e-3*(ch1_intensity) - 1e-3*(ch1_intensity(1)),ch1_value,'ro', 'MarkerSize', 5)
    title(datanames{i}, 'FontSize', 12)
    ylim([-1 2])
    xlim([0 (1e-3*(ch1_intensity(end))+0.05)])
    ylabel('Signal Height (T)', 'FontSize', 12)
    xlabel('Time Delay (s)', 'FontSize', 12)
    hold on
    if i > 2
        [beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(1e-3*(ch1_intensity) + 1e-3*(ch1_intensity(1)),ch1_value, modelfun1,[ch1_value(end) 1 0]);
        T1 = [T1; beta MSE];
    else
        [beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(1e-3*(ch1_intensity) + 1e-3*(ch1_intensity(1)),ch1_value, modelfun1,[1 0.01 0]);
        T1 = [T1; beta MSE];
    end
    plot(1e-3*(ch1_intensity)+ 1e-3*(ch1_intensity(1)),modelfun1(beta, 1e-3*(ch1_intensity)))
    legend('Original Data', 'Nonlinear Fit', 'Location', 'southeast')
    hold off
end

T1 = [T1(2:end,:); T1(1,:)];

clearvars -except T1