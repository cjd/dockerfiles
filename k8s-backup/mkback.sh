#!/bin/bash
SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
BACKUPDIR=/tank/Backups
DATE=$(date "+%Y-%m-%d")
YESTERDAY=$(TZ="UTC+14" date "+%Y-%m-%d")
# Quick snapshot of k8s volumes first
zfs snapshot "tank/Volumes@${YESTERDAY}"
# Now for the non-volume stuff
for HOSTNAME in fanless website
    do echo 
    if [ "$HOSTNAME" = "website" ]
        then DIR=/home/cjd/Docker-Data
    elif [ "$HOSTNAME" = "fanless" ]
        then DIR=/home/cjd/Docker-Data
    else echo No/Unknown host specified; exit;
    fi
    echo "##############################"
    echo "#### Backing up $HOSTNAME ####"
    echo "##############################"
    cd $BACKUPDIR || exit
    zfs snapshot "tank/Backups/${HOSTNAME}@${YESTERDAY}"
    rsync --archive --delete-during --verbose --human-readable --partial --stats --inplace -e "ssh ${SSH_OPTS}" $EXCLUDE root@$HOSTNAME:$DIR $BACKUPDIR/${HOSTNAME}
done

# Clean up to only have last week of daily snapshots, then once per week, then once per month
for DATE in $(zfs list -t all |grep "@20"|sed -e 's/^.*@\([0-9-]*\) .*$/\1/g'|sort -u|head -n -7)
    do KEEP=$(date -d "$DATE" +%u)
    if [ "$KEEP" -ne 1 ]
        then for ZFS in $(zfs list -t all|grep "$DATE" | cut -f1 -d' ')
        do zfs destroy -v "$ZFS"
        done
    fi
done
for DATE in $(zfs list -t all |grep "@20"|sed -e 's/^.*@\([0-9-]*\) .*$/\1/g'|sort -u|head -n -14)
    do KEEP=$(echo "$DATE" | cut -f3 -d'-')
    if [ "$KEEP" -gt 7 ]
        then for ZFS in $(zfs list -t all|grep "$DATE" | cut -f1 -d' ')
        do zfs destroy -v "$ZFS"
        done
    fi
done
