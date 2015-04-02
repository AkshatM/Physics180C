% This script creates .MAT files to work with from .txt files.

rootdir = 'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data\_03125M\';
dirdir = dir(strcat(rootdir,'*.txt'));

for i = 1:numel(dirdir)
    filename = strsplit(dirdir(i).name,'.');
    eval(strcat(filename{1},' = dataset(''file'',strcat(rootdir,dirdir(i).name));'));
    save(strcat(rootdir,filename{1},'.mat'),'-regexp',filename{1})
end