#!/bin/bash
SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
PROGRESS=""
SKIP_SEND=""
if [ "$1" = "-v" ]
  then PROGRESS="--progress"
  shift
fi
if [ "$1" = "-b" ]
  then SKIP_SEND="true"
  shift
fi

VOLROOT=/k8s
cd ${VOLROOT} || exit

function handle_sigterm()
{
  echo SIGTERM received - shutting down
  for VOL in */*
    do echo "Syncing $VOL to tank"
    echo -n "tank" > "${VOLROOT}/${VOL}/.nodeName"
    rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} "${VOLROOT}/${VOL}/" "root@jimbob:/tank/Volumes/${VOL}/"
  done
  echo Shutdown Complete
  exit
}

if [ "$1" = "-c" ]; then
  cp /root/.ssh/id_rsa /
  chmod 0400 /id_rsa
  SSH_OPTS="${SSH_OPTS} -i /id_rsa"
  trap handle_sigterm SIGTERM
  while true
    do echo Waiting 2h
    sleep 2h &
    wait $!
    for VOL in */*
      do echo "Syncing $VOL to tank"
      echo -n "tank" > "${VOLROOT}/${VOL}/.nodeName"
      ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} "${VOLROOT}/${VOL}/" "root@jimbob:/tank/Volumes/${VOL}/"
    done
    echo Sync Complete
  done
  exit
fi

for VOL in default/* monitoring/*
  do if [ -n "$1" ] && [ "$1" != "$VOL" ];then continue; fi
  if [ -e "${VOL}/.nodeName" ]; then
    NODE=$(cat "${VOL}/.nodeName")
  else echo "No node given for ${VOL}"
    continue
  fi
  echo Syncing "${VOL}" from "${NODE}"
  if [ "${NODE}" = "tank" ]; then
    echo Skipping as set to tank
    continue
  elif [ "${NODE}" = "jimbob" ]; then
    echo "Skipping as source==dest"
  else mkdir -p "${VOLROOT}/${VOL}/"
    ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} --exclude '.nodeName' --exclude '.pause' "root@${NODE}:/k8s/${VOL}/" "${VOLROOT}/${VOL}/"
  fi
  echo -n "${NODE}" > "${VOLROOT}/${VOL}/.nodeName"
  if [ "$SKIP_SEND" = "true" ]; then continue; fi
  for DSTNODE in elite piserve lenny
    do if [ "${DSTNODE}" != "${NODE}" ]
      then echo "Sending ${VOL} to ${DSTNODE}"
        ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} "${VOLROOT}/${VOL}/" "root@${DSTNODE}:/k8s/${VOL}/"
    fi
  done
  echo Syncing to tank
  ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} "${VOLROOT}/${VOL}/" "root@jimbob:/tank/Volumes/${VOL}/"
done
