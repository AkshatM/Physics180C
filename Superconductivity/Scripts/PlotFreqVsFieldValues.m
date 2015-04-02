% A script to collect data from Data folder, create plots from them, and
% publish the plots in the Analysis folder.

resistance_to_temperature = containers.Map({'1903', '1815','1759','1665','1535','1389','1231','1020','904','755','650','603','570'}, {2.09,2.17,2.23,2.33,2.49,2.716,3.01,3.60,4.06,5.00,5.99,6.58,7.07});
% a map object that converts resistance readings to temperature
% using provided calibration scale.

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\';

Inarray = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\In*');
% array of all files relevant to indium
Snarray = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\Sn*');
% array of all files relevant to tin
Pbarray = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\Pb*');
% array of all files relevant to lead


% loop over elements in indium array to create subplot figures
for i = 1:numel(elementlist{index})
    load(strcat(readlocation,elementlist{index}(i).name))
    temperature = resistance_to_temperature(strjoin(regexp(elementlist{index}(i).name,'[0-9]','match'),''));
    subplot(2,4,i)
    plot(eval(strcat('0.3*1699*',elementlist{index}(i).name,'(:,1)')),eval(strcat('(1/1000000)*',elementlist{index}(i).name,'(:,2)')),'x') %plot frequency against field, using conversion
    xlabel('Field (G)')
    ylabel('Frequency (MHz)')
    title(['Temperature is ', num2str(temperature),' K'])
end
