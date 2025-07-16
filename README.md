# PLCnext backup and restore a sd-card
Backup a PLCnext project on SD-Card and (delete old files) then copy it to a new card
These two bash scripts meant for 
  1. copying data from one PLCNext SD card to folder /user/Backups 
  2. delete old files on sd-card and copy the backup file (which stored on folder /user/Backups to the deleted card (without destroying the licenses contained on them)

Requirements
This script was developed and tested on a Lubuntu machine, so Ubuntu based distros are recommended for use with this script

Usage
Place the script in it's own empty folder and make it runable with "sudo chmod +x " 

run the script with "sudo bash ./script.sh"
