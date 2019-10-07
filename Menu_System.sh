#!/usr/local/Cellar/bash/5.0.11/bin/bash
#
# October 5, 2019

# 2 -> the menu script must prompt the end user for a destination folder name
# The script will attempt to create this folder, and if successful, copy the files
# in the current folder to the new folder.

# 3 -> the menu script must prompt the end user for a ZIP archive filename.
# the script will then attempt to create a compreseed archive to that filename.


echo 
echo "*************** Menu System ***************"
echo 
echo "1. List file details in current folder"
echo "2. Create backup of current files in user specified folder"
echo "3. Create a ZIP archive of current files in user specified archive"
echo "4. Output all text files one page at a time in current folder"
echo "5. Delete files in current folder"
echo "6. Exit"
echo
echo "*******************************************"
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
            echo -n "Desintation directory: "     
            read -r des_directory                           # CANNOT USE "~" to significy home directory. Must use complete filepath
            if [ ! -e "$des_directory" ]
            then
                echo "$des_directory is not a directory"
            else
                cd ~/test                                       # for testing purposes
                src_directory=$(pwd)
                echo "Source directory:         $src_directory"
                echo "Destination directory:    $des_directory"
                cp -pR "$src_directory"/* "$des_directory"
            fi
            ;;
            
        3)  echo "Create ZIP archive"           
            echo -n "Destination directory to zip to: "
            read -r des_zip
            echo -n "Desired name of new zipped file: "
            read -r des_zip_filename

            des_zip="$des_zip$des_zip_filename"

            cd ~/test
            src_zip=$(pwd)
            echo "Source directory:         $src_zip"
            echo "Destination directory:    $des_zip"

 
            zip "$des_zip" -r "$src_zip"/*

            ;;

        4)  echo "Output text files"
            cd ~/test
            for f in *.txt
            do
                less $f
                echo
            done

            ;;

        5)  echo "Delete files"
            cd ~/des_test
            cur_dir=$(pwd)
            echo "Are you sure you want to delete all files in $cur_dir? [y/n]"
            read choice
            if [ $choice = 'y' ]
            then
                rm -v $cur_dir/*

            elif [ $choice = 'n' ]
            then 
                echo "Aborting \"delete files\" command"

            else
                echo "Invalid input"
            fi
            ;;

        6)  echo "Exit";;
        *)  echo "Invalid input."
            echo
            ;;

    esac

    echo -n "Back to main menu: "

done
