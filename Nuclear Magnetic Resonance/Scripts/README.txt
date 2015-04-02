Files:

1. traverse_and_erase.py

This file starts from the root directory in which all of your data folders are kept in. It will go through every file in every subfolder, 
delete the the first six lines and write the remaining to a new file for you. I'm using this to get rid of the header data in every data file
we have. Feel free not to use it - however, it'll save you a lot of time and effort, since you'll have to delete the header files anyway.


Remember to change the rootdir parameter to the absolute path of the directory you want to target.

2. ConvertToMAT.m

This file converts every text file (with header data removed) to a MATLAB dataset, and stores that dataset in a corresponding .m file. 

3. erase_txt_files.py

A Python program to get rid of the text files once you've converted them all to .MAT. Don't have to use it.

Remember to change the rootdir parameter to the absolute path of the directory you want to target.

4. RetrieveInfo.mat

The generic data viewer. USE THIS FILE! Basically, it shows you all of the data in a folder one file at a time. You can view the next one by pressing
'Enter' in the MATLAB console. Simply change the folder, and the parameters in the directory function, and it'll work out of the box.