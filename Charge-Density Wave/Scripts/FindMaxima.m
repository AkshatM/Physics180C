% A script to find the two peaks of d ln R /d(1/T).

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Analysis\';

temperature_array = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Charge-Density Wave\Data\tempsweep*');
% array of all relevant files

regular_current = 5e-6; %amperes
first_current = 0.1e-6;

for index = 1:3 % can be any integer between 1 and 3; 2 offers best quality

    figure(1) % retain handle to single figure
    subplot(1,3,index)

    load(strcat(readlocation,temperature_array(index).name))
    inverse_temperature = 1./(eval(strcat(temperature_array(index).name,'(:,3)')));
    if index > 1
        log_of_resistance = log((1/regular_current) * eval(strcat(temperature_array(index).name,'(:,2)')));
    else
        log_of_resistance = log((1/first_current) * eval(strcat(temperature_array(index).name,'(:,2)')));
    end
    derivatives = diff(log_of_resistance)./diff(inverse_temperature);

    % plot(inverse_temperature(2:end),derivatives)

    peak_number = 3;
    [result,peaks] = Maxima(derivatives, peak_number);
    indices = [];
    for j = 1:numel(result)
    indices = [find(transpose(derivatives) == result(j))+2 indices];
    end

    transition_temperatures = 1./inverse_temperature(indices);
    %transition_temperatures = [mean(transition_temperatures(1:2)) transition_temperatures(3)];
    disp(1./inverse_temperature(indices))
    
    if index > 1
       plot(eval(strcat(temperature_array(index).name,'(:,3)')),(1/regular_current)*eval(strcat(temperature_array(index).name,'(:,2)')))
       hold on
       plot(1./inverse_temperature(indices),exp(log_of_resistance(indices)),'ro')
       xlabel('Temperature (K)', 'FontSize',14)
       ylabel('Resistance (\Omega)', 'FontSize',14)
       title(['Run ',num2str(index), '; Current: 5 \mu A'], 'FontSize',14)
       legend('Observations','Maxima','Location','northwest')
       hold off
    else
       plot(eval(strcat(temperature_array(index).name,'(:,3)')),(1/first_current)*eval(strcat(temperature_array(index).name,'(:,2)')))
       %hold on
       %plot(1./inverse_temperature(indices),exp(log_of_resistance(indices)),'ro')
       xlabel('Temperature (K)', 'FontSize',14)
       ylabel('Resistance (\Omega)', 'FontSize',14)
       title(['Run ',num2str(index), '; Current: 0.1 \mu A'], 'FontSize',14)
       legend('Observations','Maxima','Location','northwest')
       %hold off
    end
end