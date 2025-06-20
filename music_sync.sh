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
# -iconv input conversion. It allows rsync to convert file names between different character encodings during synchronization. This is particularly useful when dealing with systems that use different Unicode normalization forms, such as macOS (which uses NFD) and other systems like Synology NAS (which may use NFC).For example, by using --iconv=UTF-8-MAC,UTF-8, you’re instructing rsync to convert filenames from the macOS UTF-8 form (NFD) to the standard UTF-8 (NFC), ensuring that filenames with special characters (like ö) are treated consistently across different systems.
# log show --predicate 'process == "cron"' --info

TS=`date +"%Y-%m-%d %H:%M:%S"`
TS2=`date +"%Y-%m-%d"`
LOG="/Users/quangly/logs/rsync.$TS2.log"
SOURCE_PATH="/Volumes/SD/Music/"
# TARGET_PATH="/Volumes/music"
TARGET_PATH="/Volumes/LYUSBC/Music/"
# TARGET_PATH="/Volumes/Crucial2TB/Music/"
DAYS_OLD=1
#
echo "********** Start **********" >> "$LOG"
echo "Running at $TS" >> "$LOG"
/opt/homebrew/bin/rsync -rviu --iconv=UTF-8-MAC,UTF-8 --force --exclude '.DS_Store' --exclude 'Audio Music Apps/' --exclude 'Logic/' --exclude 'source' --exclude '._*' "${SOURCE_PATH}" "${TARGET_PATH}" >> "${LOG}" 2>&1 --delete --prune-empty-dirs 

#--dry-run
# /opt/homebrew/bin/rsync -avzu --delete --prune-empty-dirs --iconv=UTF-8-MAC,UTF-8 --exclude '.DS_Store' --exclude 'Audio Music Apps/' --exclude 'Logic/' --exclude 'source' "${SOURCE_PATH}" "${TARGET_PATH}" >> "${LOG}" 2>&1
# /opt/homebrew/bin/rsync -avzu --delete --prune-empty-dirs --ignore-existing \
#     --iconv=UTF-8-MAC,UTF-8 \
#     --exclude '.DS_Store' --exclude 'Audio Music Apps/' --exclude 'Logic/' --exclude 'source' \
#     "${SOURCE_PATH}" "${TARGET_PATH}" >> "${LOG}" 2>&1
echo "Ending at $TS2" >> "$LOG"
echo "Find and remove log files older than ${DAYS_OLD} days" >> "$LOG"
find /Users/quangly/logs/ -ctime +${DAYS_OLD}d -print0 | xargs -0 rm
echo "********** End ***********" >> "$LOG"