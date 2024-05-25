#Scheduled Backup

## Overview

This Bash script creates a compressed backup of files modified within the last 24 hours from a specified target directory and moves the backup to a specified destination directory. It ensures valid input and directory paths. Additionally, the script can be scheduled to run automatically using cron jobs.

### Steps
1. Check Arguments: Verify that exactly two arguments (target and destination directories) are provided.

2. Validate Directories: Ensure both arguments are valid directory paths.

3. Set Variables: Assign targetDirectory and destinationDirectory from the arguments, and define currentTS as the current timestamp.

4. Get Absolute Paths: Obtain the absolute paths of the current, target, and destination directories.

5. Determine Files to Backup: Identify files in the target directory modified in the last 24 hours and add them to an array.

6. Create Backup: Compress and archive the identified files into backup-<timestamp>.tar.gz.

7. Move Backup: Transfer the backup file to the destination directory.

8. Schedule the Script: Use cron jobs to schedule the script to run automatically at specified intervals.

## Usage

Make the script executable:
```bash
chmod +x backup.sh
```

### Running the Script Manually

Run the Script:
```bash
./backup.sh target_directory_name destination_directory_name
```
target_directory_name: The directory containing files to back up.
destination_directory_name: The directory to store the backup file.

### Scheduling the Script with Cron

Open Crontab:
```bash
crontab -e
```

Add a Cron Job:
```bash
0 2 * * * /path/to/backup.sh /path/to/target_directory /path/to/destination_directory
```
This example schedules the script to run daily at 2 AM.
Replace /path/to/backup.sh, /path/to/target_directory, and /path/to/destination_directory with actual paths.




