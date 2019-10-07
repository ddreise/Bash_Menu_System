#!/bin/sh
#
# October 5, 2019

# 2 -> the menu script must prompt the end user for a destination folder name
# The script will attempt to create this folder, and if successful, copy the files
# in the current folder to the new folder.

# 3 -> the menu script must prompt the end user for a ZIP archive filename.
# the script will then attempt to create a compreseed archive to that filename.


echo 
echo "***** Menu System *****"
echo 
echo "1. List file details in current folder"
echo "2. Create backup of current files in user specified folder"
echo "3. Create a ZIP archive of current files in user specified archive"
echo "4. Output all text files one page at a time in current folder"
echo "5. Delete files in current folder"
echo "6. Exit"
echo

# NOTES
# Use <command &> to run process in background

while [ "$usr_input" != "6" ]; do

    read usr_input

    case $usr_input in
        1)  echo "List File"
            echo
            ls -Clha                        # -C Force multi-column output; -lh Human-readable size; -a All
            echo
            ;;

        2)  echo "Create backup"
            echo "Desintation file: \c"     # -n doesn't work, but appending \c does
            read des_file
            cd ~/test
            cp -Rinp ./ $des_file
            
            ;;
        3) echo "Create ZIP archive";;
        4) echo "Output text files";;
        5) echo "Delete files";;
        6) echo "Exit";;
        *) echo "wrong";;

    esac

done
