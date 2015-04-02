% This script views the data in the spinflip files.

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\spinflip\';
dir1 = dir(strcat(rootdir,'cleaned_spinflip_ch1_*.mat'));

ch1_intensity = [];
ch1_value = [];

for i = 1:numel(dir1)
    load(strcat(rootdir,dir1(i).name))
    filename = strsplit(dir1(i).name,'.');
    intensity = strsplit(filename{1},'_');
    plot(eval(strcat(filename{1},'.X_Value(:)')), eval(strcat(filename{1},'.TDS2014C_CH1_(:)')))
    height = input('Press key to continue - This is Channel 1');
    ch1_intensity = [ch1_intensity str2double(intensity{end})];
    ch1_value = [ch1_value height];
end

dir2 = dir(strcat(rootdir,'cleaned_spinflip_ch2_*.mat'));

ch2_intensity = [];
ch2_value = [];

for i = 1:numel(dir2)
     load(strcat(rootdir,dir2(i).name))
     filename = strsplit(dir2(i).name,'.');
     intensity = strsplit(filename{1},'_');
     plot(eval(strcat(filename{1},'.X_Value(:)')), eval(strcat(filename{1},'.TDS2014C_CH2_(:)')))
     height = input('Press key to continue - This is Channnel 2');
     ch2_intensity = [ch2_intensity str2double(intensity{end})];
     ch2_value = [ch2_value height];
end

save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\spinflipchannel1data.mat','ch1_intensity', 'ch1_value')
save('C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\spinflipchannel2data.mat','ch2_intensity', 'ch2_value')