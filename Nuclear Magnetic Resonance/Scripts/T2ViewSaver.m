% This script views the data in the spinflip files.

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T2\';
dir1 = dir(strcat(rootdir,'cleaned_2AB_ch1_tau_*.mat'));

ch1_intensity = [];
ch1_value = [];

for i = 1:numel(dir1)
    load(strcat(rootdir,dir1(i).name))
    filename = strsplit(dir1(i).name,'.');
    intensity = strsplit(filename{1},'_');
    x_values = eval(strcat(filename{1},'.X_Value(:)'));
    positives = x_values(x_values > 0.001);
    index = find(x_values == positives(1));
    height = max(abs(eval(strcat(filename{1},'.TDS2014C_CH1_(index:end)'))));
    ch1_intensity = [ch1_intensity str2double(intensity{end})];
    ch1_value = [ch1_value height];
end

dir2 = dir(strcat(rootdir,'cleaned_2AB_ch2_tau_*.mat'));

ch2_intensity = [];
ch2_value = [];

for i = 1:numel(dir2)
     load(strcat(rootdir,dir2(i).name))
     filename = strsplit(dir2(i).name,'.');
     intensity = strsplit(filename{1},'_');
     x_values = eval(strcat(filename{1},'.X_Value(:)'));
     positives = x_values(x_values > 0.001);
     index = find(x_values == positives(1));
     height = max(abs(eval(strcat(filename{1},'.TDS2014C_CH2_(index:end)'))));
     ch2_intensity = [ch2_intensity str2double(intensity{end})];
     ch2_value = [ch2_value height];
end

save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T2channel1data.mat','ch1_intensity', 'ch1_value')
save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\T2channel2data.mat','ch2_intensity', 'ch2_value')