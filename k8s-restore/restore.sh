#!/bin/sh
SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
echo "Checking for the existing data"
FORCE=0
cd /mnt
for PV in *
  do if ssh $SSH_OPTS root@jimbob test -f /tank/Volumes/${NS}/${PV}-pvc/.pause
    then echo Pausing; sleep 1d
  fi
  # Check for node pv was last on
  LASTNODE=`ssh $SSH_OPTS root@jimbob cat /tank/Volumes/${NS}/${PV}-pvc/.nodeName`
  if [ -n "$LASTNODE" ]
    then echo Last running on ${LASTNODE} - Now running on ${NODE}
    if [ ! -z "$LASTNODE" -a "$LASTNODE" != "$NODE" ]
      then echo Syncing ${PV} from ${LASTNODE}
      if ping -c 1 ${LASTNODE}
          then rsync -av -e "ssh $SSH_OPTS" --delete-during root@${LASTNODE}:/k8s/${NS}/${PV}-pvc/ /mnt/${PV}/
          else FORCE=1
      fi
    fi
  else echo No previous nodeName found
  fi
  if ssh $SSH_OPTS root@jimbob test -f /tank/Volumes/${NS}/${PV}-pvc/.force_restore
  then FORCE=1
  fi
  if [ $FORCE -eq 1 ]
    then echo Restoring ${PV} from backup
    rsync -av  -e "ssh $SSH_OPTS" --delete-during root@jimbob:/tank/Volumes/${NS}/${PV}-pvc/ /mnt/${PV}/
  fi
  ssh $SSH_OPTS root@jimbob "echo -e $NODE > /tank/Volumes/${NS}/${PV}-pvc/.nodeName"
done
echo "  >> Data loaded"
