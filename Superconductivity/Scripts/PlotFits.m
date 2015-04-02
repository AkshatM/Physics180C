% A script to plot different kinds of nonlinear regressions to data.

cd 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Analysis\';

Elements = {'Indium','Tin','Lead'};
critical_temperatures = [3.4 3.7 7.1];
critical_fields_at_zero = [280 310 810];
index = 3;

load(strcat('TempVsFields_',Elements{index},'.mat'))

%define some functions
modelfunc1 = @(p,x) p(1)*(1 - (x/p(2)).^2); %for testing free fit
modelfunc2 = @(q,x) q(1)*(1 - (x/critical_temperatures(index)).^2); %for testing fit with critical temperature fixed
if index < 3
    desired_temps = 0:0.01:5;
else
    desired_temps = 0:0.01:8;
end

[free_fit,R1,J1,CovB1,MSE_free_fit,ErrorModelInfo1] = nlinfit(temperatures,critical_fields,modelfunc1,[critical_fields_at_zero(index),critical_temperatures(index)]);
[fixed_fit,R2,J2,CovB2,MSE_fixed_fit,ErrorModelInfo2] = nlinfit(temperatures,critical_fields,modelfunc2,[critical_fields_at_zero(index)]);

figure()
hold on
xlim([0 desired_temps(end)])
if index < 3
    ylim([0 500])
else
    ylim([0 1000])
end
plot(temperatures,critical_fields,'rx','LineWidth',2)
plot(desired_temps,modelfunc1(free_fit,desired_temps),'-g')
plot(desired_temps,modelfunc2(fixed_fit,desired_temps),'-b')
plot(desired_temps,modelfunc2([critical_fields_at_zero(index),critical_temperatures(index)],desired_temps),'-k')
errorbar(temperatures,critical_fields,transpose(errorbars_array),'m','LineStyle','none');
%plot(temperatures - (desired_temps(modelfunc1(free_fit,desired_temps) == 0) - temperatures), critical_fields, 'bo')
xlabel('Temperature (K)', 'FontSize',16)
ylabel('Critical Field (G)','FontSize',16)
legend({'Observed Data','Free Fit','Fit with T_{c} Fixed','Theoretical Curve'},'FontSize',16)
title(['Critical Field Vs. Temperature for ',Elements{index}],'FontSize',16)
if index < 3
    text(0.25,50,['Critical Field at T = 0 from Fixed T_{c} Fit:  ',num2str(fixed_fit(1)),' G'],'FontSize',16)
    text(0.25,30,['Critical Field at T = 0 from Free Parameter Fit:  ',num2str(free_fit(1)),' G'],'FontSize',16)
    1 - fcdf((MSE_fixed_fit*7)/(MSE_free_fit*6),7,6)
    if index == 1
        if 1 - fcdf((MSE_fixed_fit*7)/(MSE_free_fit*6),7,6) < 0.05
            percentage_error = ((free_fit(1) - critical_fields_at_zero(index))*100)/critical_fields_at_zero(index);
            correlation_coefficient_squared = 1 - ((numel(R1) - 1)/(7))*(sum(R1.^2)/sum((R1 - mean(critical_fields)).^2)); 
            text(0.25,80,['R^{2} for Theoretical Curve = ',num2str(correlation_coefficient_squared)],'FontSize',16)
        else
            percentage_error = ((fixed_fit(1) - critical_fields_at_zero(index))*100)/critical_fields_at_zero(index);
            correlation_coefficient_squared = 1 - ((numel(R2) - 1)/(6))*(sum(R2.^2)/sum((R2 - mean(critical_fields)).^2));
            text(0.25,80,['R^{2} for Theoretical Curve = ',num2str(correlation_coefficient_squared)],'FontSize',16)
        end
    elseif index == 2
        if 1 - fcdf((MSE_fixed_fit*8)/(MSE_free_fit*7),8,7) < 0.05
            percentage_error = ((free_fit(1) - critical_fields_at_zero(index))*100)/critical_fields_at_zero(index);
            correlation_coefficient_squared = 1 - ((numel(R1) - 1)/(8))*(sum(R1.^2)/sum((R1 - mean(critical_fields)).^2)); 
            text(0.25,80,['R^{2} for Theoretical Curve = ',num2str(correlation_coefficient_squared)],'FontSize',16)
        end
    end
else
    text(0.25,100,['Critical Field at T = 0 from Fixed T_{c} Fit:  ',num2str(fixed_fit(1)),' G'],'FontSize',16)
    text(0.25,60,['Critical Field at T = 0 from Free Parameter Fit:  ',num2str(free_fit(1)),' G'],'FontSize',16)
    1 - fcdf((MSE_fixed_fit*12)/(MSE_free_fit*11),12,11)
    if 1 - fcdf((MSE_fixed_fit*12)/(MSE_free_fit*11),12,11) < 0.05
        percentage_error = ((free_fit(1) - critical_fields_at_zero(index))*100)/critical_fields_at_zero(index);
        correlation_coefficient_squared = 1 - ((numel(R1) - 1)/(12))*(sum(R2.^2)/sum((R2 - mean(critical_fields)).^2));
        text(0.25,160,['R^{2} for Theoretical Curve = ',num2str(correlation_coefficient_squared)],'FontSize',16)
    else
        percentage_error = ((fixed_fit(1) - critical_fields_at_zero(index))*100)/critical_fields_at_zero(index);
        correlation_coefficient_squared = 1 - ((numel(R2) - 1)/(11))*(sum(R2.^2)/sum((R2 - mean(critical_fields)).^2));
        text(0.25,160,['R^{2} for Theoretical Curve = ',num2str(correlation_coefficient_squared)],'FontSize',16)
    end
end
hold off
