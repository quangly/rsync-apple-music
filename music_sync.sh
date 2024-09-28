#!/bin/bash
# Author: Quang Ly
# To Add cronjob, example below.
# crontab -e
# on the hour and half hour
# Run on the hour and half hour.
# 0,30 * * * * /Users/quangly/Library/CloudStorage/GoogleDrive-quangdly@gmail.com/My\ Drive/rsync-apple-music/music_sync.sh &
# -r (recursive) 
# -a (archive: symbolic links, devices, attributes, permissions, ownerships, etc. are preserved in the transfer. Additionally, compression will be used to reduce the size of data portions of the transfer)
# -i output change-summary of for all udpates
# -p preserve permissions
# -u, --update This forces rsync to skip any files which exist on the destination and have a modified time that is newer than the source file. (If an existing destination file has a modification time equal to the source file's, it will be updated if the sizes are different.)

TS=`date +"%Y-%m-%d %H:%M:%S"`
TS2=`date +"%Y-%m-%d"`
LOG="/Users/quangly/logs/rsync.$TS2.log"
# SOURCE_PATH="/Users/quangly/Music/"
SOURCE_PATH="/Volumes/SD/Music/"
TARGET_PATH="/Volumes/music"
# TARGET_PATH="/Volumes/quangly.com/music"
DAYS_OLD=1

echo "********** Start **********" >> "$LOG"
echo "Running at $TS" >> "$LOG"
rsync -rviu --iconv=UTF-8-MAC,UTF-8  --exclude '.DS_Store' --exclude 'Audio Music Apps/' --exclude 'Logic/' --exclude 'source' "${SOURCE_PATH}" "${TARGET_PATH}" >> "${LOG}" 2>&1 --delete --prune-empty-dirs
# /usr/bin/rsync -ravi --iconv=UTF-8-MAC,UTF-8 --exclude 'dir1/' /Users/quangly/Music/source/ /Volumes/music/destination >> "${LOG}" 2>&1 --delete --prune-empty-dirs
echo "Ending at $TS" >> "$LOG"
echo "Find and remove log files older than ${DAYS_OLD} days" >> "$LOG"
find /Users/quangly/logs/ -ctime +${DAYS_OLD}d -print0 | xargs -0 rm
echo "********** End ***********" >> "$LOG"