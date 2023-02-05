#!/bin/sh
echo "Checking for the existing data"
mkdir -p /backup
mount -o nolock 192.168.0.2:/tank/Volumes/$NS /backup
cd /mnt
for PV in *
        do if [ -f /backup/${PV}-pvc/.pause ]
                then echo Pausing; sleep 1d
        fi
        # Check for node pv was last on
        if [ -f /backup/${PV}-pvc/.nodeName ]
                then LASTNODE=`cat /backup/${PV}-pvc/.nodeName`
                echo Last running on ${LASTNODE} - Now running on ${NODE}
                if [ ! -z "$LASTNODE" -a "$LASTNODE" != "$NODE" ]
                        then echo Syncing ${PV} from ${LASTNODE}
                        mkdir /oldk8s
                        mount -o nolock $LASTNODE:/k8s /oldk8s
                        if mountpoint -q /oldk8s
                          then rsync -av --delete-during /oldk8s/${NS}/${PV}-pvc/ /mnt/${PV}/
                          umount /oldk8s
                        else touch /backuo/${PV}-pvc/.force_restore
                        fi
                fi
        else echo No previous nodeName found
        fi
        if [ -f /backup/${PV}-pvc/.force_restore ]
                then rm  /backup/${PV}-pvc/.force_restore 2>/dev/null
                echo Restoring ${PV} from backup
                rsync -av --delete-during /backup/${PV}-pvc/ /mnt/${PV}/
        fi
        echo -e $NODE > /backup/${PV}-pvc/.nodeName
done
echo "  >> Data loaded"
