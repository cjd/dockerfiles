#!/bin/sh

echo "192.168.0.2  jimbob" >> /etc/hosts
echo "192.168.0.4  elite" >> /etc/hosts
echo "192.168.0.5  lenny" >> /etc/hosts
echo "192.168.0.8  fanless" >> /etc/hosts
echo "192.168.0.9  piserve" >> /etc/hosts

SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
echo "Checking for the existing data"
FORCE=0
cd /mnt
for PV in *
  do echo Checking /k8s/${NS}/${PV}
  if ssh $SSH_OPTS root@jimbob test -f /k8s/${NS}/${PV}/.pause
    then echo Pausing; sleep 1d
  fi
  # Check for node pv was last on
  LASTNODE=`ssh $SSH_OPTS root@jimbob cat /k8s/${NS}/${PV}/.nodeName`
  if [ -n "$LASTNODE" ]
    then echo Last running on ${LASTNODE} - Now running on ${NODE}
    if [ ! -z "$LASTNODE" -a "$LASTNODE" != "$NODE" ]
      then echo Syncing ${PV} from ${LASTNODE}
      if ping -c 1 ${LASTNODE}
          then rsync -av -e "ssh $SSH_OPTS" --delete-during root@${LASTNODE}:/k8s/${NS}/${PV}/ /mnt/${PV}/
          else FORCE=1
      fi
    fi
  else echo No previous nodeName found
  fi
  if ssh $SSH_OPTS root@jimbob test -f /k8s/${NS}/${PV}/.force_restore
  then FORCE=1
  fi
  if [ $FORCE -eq 1 ]
    then echo Restoring ${PV} from backup
    rsync -av  -e "ssh $SSH_OPTS" --delete-during root@jimbob:/k8s/${NS}/${PV}/ /mnt/${PV}/
    FORCE=0
  fi
  ssh $SSH_OPTS root@jimbob "echo -e $NODE > /k8s/${NS}/${PV}/.nodeName"
done
echo "  >> Data loaded"
