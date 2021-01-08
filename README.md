# rsync-apple-music
Automate backup of Apple Music to External Drive. Will only copy new or renamed files limiting unnecessary bandwidth

Of course, this rsync script can be used to back up anything to another mounted drive.

# Features
- Log rotation after X number of days
- Adjustable parameters
- Cron Job

# CRON Job Settings
Runs every 30 minutes

`crontab -e`

`0,30 * * * * /Users/quangly/Google\ Drive/rsync-apple-music/music_sync.sh &`

