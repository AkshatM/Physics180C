%This script plots all the original data and saves information about them.
%Manual input will be needed!

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T1\';
dir1 = dir(strcat(rootdir,'cleaned_AB_ch1_tau_*.mat'));
 
ch1_intensity_m = [];
ch1_value_m = [];
 
for i = 1:numel(dir1)
      load(strcat(rootdir,dir1(i).name))
      filename = strsplit(dir1(i).name,'.');
      intensity = strsplit(filename{1},'_');
      index = find(eval(strcat(filename{1},'.TDS2014C_CH1_(:)')) == max(eval(strcat(filename{1},'.TDS2014C_CH1_(:)'))));
      amplitude = median(eval(strcat(filename{1},'.TDS2014C_CH1_(index:index + 100)')));
      ch1_intensity_m = [ch1_intensity_m str2double(intensity{end})];
      ch1_value_m = [ch1_value_m amplitude];
end

dir2 = dir(strcat(rootdir,'cleaned_AB_ch2_tau_*.mat'));

ch2_intensity_m = [];
ch2_value_m = [];

for i = 1:numel(dir2)
     load(strcat(rootdir,dir2(i).name))
     filename = strsplit(dir2(i).name,'.');
     intensity = strsplit(filename{1},'_');
     index = find(eval(strcat(filename{1},'.TDS2014C_CH2_(:)')) == max(eval(strcat(filename{1},'.TDS2014C_CH2_(:)'))));
     amplitude = median(eval(strcat(filename{1},'.TDS2014C_CH2_(index:index + 100)')));
     ch2_intensity_m = [ch2_intensity_m, str2double(intensity{end})];
     ch2_value_m = [ch2_value_m amplitude];
end


%save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T1channel1data.mat','ch1_intensity', 'ch1_value')
%save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T1channel2data.mat','ch2_intensity', 'ch2_value')
save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T1medianchannel1data.mat','ch1_intensity', 'ch1_value')
save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T1medianchannel2data.mat','ch2_intensity', 'ch2_value')