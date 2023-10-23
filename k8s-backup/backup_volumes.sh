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
for VOL in */*
  do if [ -n "$1" ] && [ "$1" != "$VOL" ];then continue; fi
  if [ -e "${VOL}/.nodeName" ]
  then NODE=$(cat "${VOL}/.nodeName")
    else echo "No node given for ${VOL}"; continue
  fi
  echo Syncing "${VOL}" from "${NODE}"
  if [ "${NODE}" != "jimbob" ]
    then mkdir -p "${VOLROOT}/${VOL}/"
    ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} --exclude '.nodeName' --exclude '.pause' "root@${NODE}:/k8s/${VOL}/" "${VOLROOT}/${VOL}/"
  else echo "Skipping as source==dest"
  fi
  echo -n "${NODE}" > "${VOLROOT}/${VOL}/.nodeName"
  if [ "$SKIP_SEND" = "true" ]; then continue; fi
  for DSTNODE in fanless elite piserve
    do if [ "${DSTNODE}" != "${NODE}" ]
      then echo "Sending ${VOL} to ${DSTNODE}"
        ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} "${VOLROOT}/${VOL}/" "root@${DSTNODE}:/k8s/${VOL}/"
    fi
  done
  echo Syncing to tank
  ionice -c 3 rsync -av -e "ssh ${SSH_OPTS}" --delete-during ${PROGRESS} "${VOLROOT}/${VOL}/" "root@jimbob:/tank/Volumes/${VOL}/"
done
