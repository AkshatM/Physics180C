%This script plots all the original data and saves information about them.
%Manual input will be needed!

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\_03125M\';
dir1 = dir(strcat(rootdir,'cleaned_ch1_tau_*.mat'));
 
ch1_intensity = [];
ch1_value = [];
 
for i = 1:numel(dir1)
      load(strcat(rootdir,dir1(i).name))
      filename = strsplit(dir1(i).name,'.');
      intensity = strsplit(filename{1},'_');
      try
        index = find(eval(strcat(filename{1},'.TDS2014C_CH1_(:)')) == max(eval(strcat(filename{1},'.TDS2014C_CH1_(:)'))));
        amplitude = mean(eval(strcat(filename{1},'.TDS2014C_CH1_(index:index + 600)')));
     catch
        index = find(eval(strcat(filename{1},'.TDS2014CCH1(:)')) == max(eval(strcat(filename{1},'.TDS2014CCH1(:)'))));
        amplitude = mean(eval(strcat(filename{1},'.TDS2014CCH1(index:index + 600)')));
     end
      ch1_intensity = [ch1_intensity str2double(intensity{end})];
      ch1_value = [ch1_value amplitude];
end

dir2 = dir(strcat(rootdir,'cleaned_ch2_tau_*.mat'));

ch2_intensity = [];
ch2_value = [];

for i = 1:numel(dir2)
     load(strcat(rootdir,dir2(i).name))
     filename = strsplit(dir2(i).name,'.');
     intensity = strsplit(filename{1},'_');
    try
        index = find(eval(strcat(filename{1},'.TDS2014C_CH2_(:)')) == max(eval(strcat(filename{1},'.TDS2014C_CH2_(:)'))));
        amplitude = mean(eval(strcat(filename{1},'.TDS2014C_CH2_(index:index + 600)')));
     catch
        index = find(eval(strcat(filename{1},'.TDS2014CCH2(:)')) == max(eval(strcat(filename{1},'.TDS2014CCH2(:)'))));
        amplitude = mean(eval(strcat(filename{1},'.TDS2014CCH2(index:index + 600)')));
     end
     ch2_intensity = [ch2_intensity str2double(intensity{end})];
     ch2_value = [ch2_value amplitude];
end

save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\M03125channel1data.mat','ch1_intensity', 'ch1_value')
save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\M03125channel2data.mat','ch2_intensity', 'ch2_value')