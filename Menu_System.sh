#!/usr/local/Cellar/bash/5.0.11/bin/bash
#
# Operating Systems - Assignment 2
# Menu System
#
# Purpose: Menu system for manipulating files
#
# By: Daniel Dreise
# All Rights Reserved 
#
# October 5, 2019



# Output main menu
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


# Loop continues until user Exits program
while [ "$usr_input" != "6" ]; do

    read usr_input                          # wait for user input

    case $usr_input in      
        1)  echo "List File"
            echo
            ls -Clha                        # Output file information: -C Force multi-column output; -lh Human-readable size; -a All
            echo
            ;;                              # break

        2)  echo "Create backup"
            echo -n "Desintation directory: "               
            read -r des_directory                           # CANNOT USE "~" to significy home directory. Must use complete filepath
                                                            # Waits for user to input filepath

            if [ ! -e "$des_directory" ]                    # Checks to see if input filepath is actually a directory/file
            then
                echo "$des_directory is not a directory"    # if not, output that it's not a directory/filename
            else
                #cd ~/test                                          # for testing purposes
                src_directory=$(pwd)                                # set current directory filepath to variable src_directory
                echo "Source directory:         $src_directory"     # output source directroy
                echo "Destination directory:    $des_directory"     # output destination directory
                cp -pR "$src_directory"/* "$des_directory"          # copy files to new directory: -R recursively; -p keep attributes
            fi
            ;;
            
        3)  echo "Create ZIP archive"           
            echo -n "Destination directory to zip to: "
            read -r des_zip                                     # Wait for user input for destination directory
            echo -n "Desired name of new zipped file: "
            read -r des_zip_filename                            # Wait for user input for destination filename

            des_zip="$des_zip$des_zip_filename"                 # Append filename to destination directory

            #cd ~/test
            src_zip=$(pwd)                                      # Set current working directory to src_zip
            echo "Source directory:         $src_zip"           
 
            zip "$des_zip" -r "$src_zip"/*                      # ZIP files in current directory to chosen directory with chosen filename

            ;;

        4)  echo "Output text files"
            #cd ~/test
            for f in *.txt              # Loop through all files with .txt filetype
            do
                less $f                 # Output text file to screen
                echo
            done

            ;;

        5)  echo "Delete files"
            #cd ~/des_test
            cur_dir=$(pwd)                                                          # Set current directory to variable cur_dir
            echo "Are you sure you want to delete all files in $cur_dir? [y/n]"     # Confirm deletion choice
            read choice                                                             
            if [ $choice = 'y' ]                            # If yes, delete all files in current directory
            then
                rm -v $cur_dir/*

            elif [ $choice = 'n' ]                          # If no, abort delete command
            then 
                echo "Aborting \"delete files\" command"

            else
                echo "Invalid input"                        # If invalid input, return to main menu
            fi
            echo
            ;;

        6)  echo "Exit";;                   # Exit program
        *)  echo "Invalid input."           # If invalid input, output invalid input.
            echo
            ;;

    esac

    echo -n "Back to main menu: "

done