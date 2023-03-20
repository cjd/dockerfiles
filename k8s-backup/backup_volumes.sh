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
cd ${VOLROOT}
for VOL in */*
  do if [ ! -z "$1" -a "$1" != "$VOL" ];then continue; fi
  if [ -e ${VOL}/.nodeName ]
    then NODE=`cat ${VOL}/.nodeName`
    else continue
  fi
  echo Syncing ${VOL} from ${NODE}
  mkdir -p ${VOLROOT}/${VOL}/
  rsync -av -e "ssh ${SSH_OPTS}" --delete-after ${PROGRESS} --exclude '.nodeName' --exclude '.pause' root@${NODE}:/k8s/${VOL}/ ${VOLROOT}/${VOL}/
  if [ "$SKIP_SEND" = "true" ]; then continue; fi
  for DSTNODE in fanless elite
    do if [ "${DSTNODE}" != "${NODE}" ]
      then echo Sending ${VOL} to ${DSTNODE}
        rsync -av -e "ssh ${SSH_OPTS}" --delete-after ${PROGRESS} ${VOLROOT}/${VOL}/ root@${DSTNODE}:/k8s/${VOL}/
    fi
  done
  rsync -av -e "ssh ${SSH_OPTS}" --delete-after ${PROGRESS} ${VOLROOT}/${VOL}/ root@jimbob:/tank/Volumes/${VOL}/
done
