% A script to collect critical fields at each temperature.

resistance_to_temperature = containers.Map({'1903', '1815','1759','1665','1535','1389','1231','1020','904','755','650','603','570'}, {2.09,2.17,2.23,2.33,2.49,2.716,3.01,3.60,4.06,5.00,5.99,6.58,7.07});
% a map object that converts resistance readings to temperature
% using provided calibration scale.

readlocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\';
savelocation = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Analysis\';


Inarray = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\In*');
% array of all files relevant to indium
Snarray = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\Sn*');
% array of all files relevant to tin
Pbarray = dir('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Superconductivity\Data\Pb*');
% array of all files relevant to lead

temperature_critical_field_map = containers.Map('KeyType','double', 'ValueType','any');

elementlist = {Pbarray,Snarray,Inarray};
index = 3;

errorbars_array = zeros(1,numel(elementlist{index}));

for i = 1:numel(elementlist{index})
    load(strcat(readlocation,elementlist{index}(i).name))
    temperature = resistance_to_temperature(strjoin(regexp(elementlist{index}(i).name,'[0-9]','match'),''));
    critical_field_index = MaxNegSlope(eval(elementlist{index}(i).name));
    errorbars_array(i) = ErrorBar(eval(elementlist{index}(i).name), critical_field_index);
    % the following line maps the temperature to the critical field value
    temperature_critical_field_map(temperature) = ...
        eval(['0.3*1699*',elementlist{index}(i).name,'(critical_field_index,1)']);
    clearvars -except temperature_critical_field_map Inarray Pbarray Snarray resistance_to_temperature i readlocation savelocation index elementlist errorbars_array
end

errorbars_array(errorbars_array == 0) = NaN;

temperatures = cell2mat(keys(temperature_critical_field_map));
critical_fields = cell2mat(values(temperature_critical_field_map));

if index == 1
    save([savelocation,'TempVsFields_Lead.mat'],'temperature_critical_field_map','temperatures','critical_fields','errorbars_array')
elseif index == 2
    save([savelocation,'TempVsFields_Tin.mat'],'temperature_critical_field_map','temperatures','critical_fields','errorbars_array')
elseif index == 3
    save([savelocation,'TempVsFields_Indium.mat'],'temperature_critical_field_map','temperatures','critical_fields','errorbars_array')
end