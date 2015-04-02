import os

rootdir = r'='

for directory, subdirectory, files_in_directory in os.walk(rootdir):
    for filename in files_in_directory:
        if '.txt' in filename:
            os.remove(directory+"\\" +filename)
