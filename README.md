# rsync-apple-music
Automate backup of Apple Music to External Drive. Will only copy new or renamed files limiting unnecessary bandwidth. If files in target do not exist, remove them. This is to prevent orphaned files that have been renamed from source.

Of course, this rsync script can be used to back up anything to another mounted drive.

# Features
- Log rotation after X number of days. STDERR to STDOUT
- Adjustable parameters
- Cron Job
- UTF-8 normalization to rsync script using --iconv to handle macOS NFD and Synology NAS NFC encoding differences, preventing re-syncing of files with special characters.

# CRON Job Settings
Runs every 30 minutes <br>
```crontab -e```

```0,30 * * * * /Users/quangly/Google\ Drive/rsync-apple-music/music_sync.sh &```

#Exclusions
Exclude certain directories in Apple Music folder <br>
```--exclude 'Audio Music Apps/'```
```--exclude 'Logic/'```

# Execute on Demand
```chmod +x music_sync.sh```
```./music_sync.sh```
