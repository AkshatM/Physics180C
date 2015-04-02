import os

# This program starts at the directory we've called rootdir.

# It goes through every directory, takes stock of all the files in each directory,
# writes everything but the first six lines to another file with a similar name,
# and then deletes the original file.

# Be CAREFUL with this program! Test it out on a copy of the root directory you want
# to use it on if you aren't completely sure of how to use it.

#The new file created is exactly the same as the old file, except it has the word 'cleaned_'
# attached at the beginning of the filename.

#Edit the string rootdir below (in single quotes) to be the absolute path
#to where your stuff is stored. For instance, on my system, I've stored
#it in the Data folder on my Desktop. Do not change the 'r' - it tells Python
#that it's dealing with a raw string, and will cause problems for you if you
#accidentally delete it.

rootdir = r'C:\Users\Akshat Mahajan\Desktop\Physics 180C\Nuclear Magnetic Resonance\Data'

for directory, subdirectory, files_in_directory in os.walk(rootdir):
    for filename in files_in_directory: #for every file in a list of files in the directory
        lines = open(directory+"\\" +filename).readlines() #read content of each file
        newfile = open(directory+"\\" +'cleaned_'+filename, 'a+') #create a new file
        for line in lines[7:]: #for every line after and including the seventh one in lines; 7 is chosen as it is the first line after ***End of Header***
            newfile.write(line) #write this line to the end of our new file
        newfile.close() #close the file so our program doesn't write to it anymore
        os.remove(directory+"\\" +filename) #remove the original file


