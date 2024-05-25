#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# Set two variables equal to the values of the first and second command line arguments
targetDirectory=$1
destinationDirectory=$2

# Display the values of the two command line arguments in the terminal
echo "The target directory is $targetDirectory"
echo "The destination directory is $destinationDirectory"

# Define a variable as the current timestamp, expressed in seconds
currentTS=$(date +%s)

# Define a variable to store the name of the archived and compressed backup file
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# Define a variable with the absolute path of the current directory
origAbsPath=$(pwd)

# Define a variable equals the absolute path of the destination directory
cd $destinationDirectory
destDirAbsPath=$(pwd)

# Change directories from the current working directory to the target directory
cd $origAbsPath
cd $targetDirectory

# Define a variable as the timestamp (in seconds) 24 hours prior to the current timestamp
yesterdayTS=$(($currentTS - 24*60*60))

# Declare an array
declare -a toBackup

for file in $(ls) # Return all files and directories in the current folder
do
  # Check whether the file was modified within the last 24 hours
  if (( $(date -r $file +%s) > $yesterdayTS ))
  then
    # Add the file that was updated in the past 24-hours to the toBackup array
    toBackup+=($file)
  fi
done

# Compress and archive the files, using the toBackup array of filenames
tar -czvf $backupFileName ${toBackup[@]}

# Move the file to the destination directory
mv $backupFileName $destDirAbsPath

