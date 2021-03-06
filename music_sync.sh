#!/bin/bash
# To Add cronjob, example below.
# crontab -e
# 0,30 * * * * /Users/quangly/Google\ Drive/rsync-apple-music/music_sync.sh &

TS=`date +"%Y-%m-%d %H:%M:%S"`
TS2=`date +"%Y-%m-%d"`
LOG="/Users/quangly/Downloads/logs/rsync.$TS2.log"
SOURCE_PATH="/Users/quangly/Music/"
TARGET_PATH="/Volumes/music"
DAYS_OLD=2
echo "--- Start -----" >> "$LOG"
echo "Running at $TS" >> "$LOG"
/usr/bin/rsync -ravip  --exclude '.DS_Store' --exclude 'Audio Music Apps/' --exclude 'Logic/' --exclude 'source' "${SOURCE_PATH}" "${TARGET_PATH}" >> "${LOG}" 2>&1 --delete
# /usr/bin/rsync -ravi --exclude 'dir1/' /Users/quangly/Music/source/ /Volumes/music/destination >> "${LOG}" 2>&1 --delete
echo "Ending at $TS" >> "$LOG"
echo "Find and remove log files older than ${DAYS_OLD} days" >> "$LOG"
find /Users/quangly/Downloads/logs/ -ctime +${DAYS_OLD}d -print0 | xargs -0 rm
echo "--- End -----" >> "$LOG"