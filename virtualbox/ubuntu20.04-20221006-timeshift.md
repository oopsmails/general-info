# Ubuntu Time Shift to Backup and Restore

## Install

sudo apt install timeshift

## Backup

Open timeshift

Select RSYNC and hit the Next button

Select backup destination. timeshift will search your system for available file-system partition and provide you with an option to where to create backup file.

Select how often you wish to perform the system backup and how many backup snapshots you wish to retrain before the first backup is overwritten.

As the screenshot indicates the home directories are excluded by default. Depending on you work environment select whether you wish to include home directories into the backup.

This will conclude your initial backup schedule setup. Hit the Finish button.

The backup has not been created yet. You can either wait until the timeshift automatically triggers the backup or simply hit the Create button to perform the previously predefined backup now.


Wait for the backup to complete.


## Restore

At this point we will restore the system from the previously created system backup snapshot. Select a backup snapshot from which you wish to restore and click on the Restore button.


Timeshift give you an option on how to restore from your backup. Unless you know what you are doing simply hit the Next button to go with the default.


The Timeshit will provide you with a list of changes it will take to restore from the backup just to make sure no data is lost in the process.


Once you hit the Next button the system will be restored and restarted. All done.


## Create and restore backup by using the Timeshift’s command line


Create a first backup simply by executing the below command:

```
$ sudo timeshift --create
First run mode (config file not found)
Selected default snapshot type: RSYNC
Mounted /dev/sda2 at /media/root/359151f5-efb9-483d-a738-894d57e2d8c8.
Selected default snapshot device: /dev/sda2
------------------------------------------------------------------------------
Estimating system size...
Creating new snapshot...(RSYNC)
Saving to device: /dev/sda2, mounted at path: /media/root/359151f5-efb9-483d-a738-894d57e2d8c8
Synching files with rsync...
Created control file: /media/root/359151f5-efb9-483d-a738-894d57e2d8c8/timeshift/snapshots/2020-02-19_18-32-36/info.json
RSYNC Snapshot saved successfully (39s)
Tagged snapshot '2020-02-19_18-32-36': ondemand
```


The above command will also create a new configuration file located at the following location: /etc/timeshift.json.


List all your currently created system backup screenshots:

```
$ sudo timeshift --list
Device : /dev/sda2
UUID   : 359151f5-efb9-483d-a738-894d57e2d8c8
Path   : /media/root/359151f5-efb9-483d-a738-894d57e2d8c8
Mode   : RSYNC
Device is OK
1 snapshots, 197.7 GB free

Num     Name                 Tags  Description  
------------------------------------------------------------------------------
0    >  2020-02-19_18-32-36  O 

```

Restore from the backup snapshot:

```
$ sudo timeshift --restore --snapshot "2020-02-19_18-32-36"
```

Delete selected backup snapshot:

```
$ sudo timeshift --delete  --snapshot '2014-10-12_16-29-08'
```









## Refs:

https://linuxconfig.org/ubuntu-20-04-system-backup-and-restore




