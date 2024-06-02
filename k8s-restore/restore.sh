#!/bin/sh
# shellcheck disable=SC2086
{
echo "192.168.0.2  jimbob"
echo "192.168.0.4  elite"
echo "192.168.0.5  lenny"
echo "192.168.0.8  fanless"
echo "192.168.0.9  piserve"
} >> /etc/hosts

# Fix for permissions when pod not running as root (https://github.com/kubernetes/kubernetes/issues/57923)
cp /root/.ssh/id_rsa /root
chmod 0400 /root/id_rsa

SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /root/id_rsa'

echo "Checking for the existing data"
FORCE=0
cd /mnt || exit
for PV in *
  do echo "Checking /k8s/${NS}/${PV}"
  if ssh $SSH_OPTS root@jimbob test -f /k8s/${NS}/${PV}/.pause
    then echo Pausing; sleep 1d
  fi
  # Check for node pv was last on
  LASTNODE=$(ssh $SSH_OPTS root@jimbob cat /k8s/${NS}/${PV}/.nodeName)
  if [ -n "$LASTNODE" ]
    then echo Last running on ${LASTNODE} - Now running on ${NODE}
    if [ -n "$LASTNODE" ] && [ "$LASTNODE" != "$NODE" ]
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
  # shellcheck disable=SC2029
  ssh $SSH_OPTS root@jimbob "echo -e ${NODE} > /k8s/${NS}/${PV}/.nodeName"
done
echo "  >> Data loaded"
