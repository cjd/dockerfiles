#!/bin/bash
SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

VOLROOT=/k8s
cd ${VOLROOT} || exit

function handle_sigterm() {
  echo SIGTERM received - shutting down
  for VOL in */*; do
    echo "Syncing $VOL to tank"
    echo -n "tank" >"${VOLROOT}/${VOL}/.nodeName"
    rsync -avx -e "ssh ${SSH_OPTS}" --delete-during --exclude "lost+found" "${VOLROOT}/${VOL}/" "root@nas.default:/tank/Volumes/${VOL}/"
  done
  echo Shutdown Complete
  exit
}

cp /root/.ssh/id_rsa /
chmod 0400 /id_rsa
SSH_OPTS="${SSH_OPTS} -i /id_rsa"
trap handle_sigterm SIGTERM
while true; do
  echo Waiting 2h
  sleep 2h &
  wait $!
  for VOL in */*; do
    echo "Syncing $VOL to tank"
    echo -n "tank" >"${VOLROOT}/${VOL}/.nodeName"
    ionice -c 3 rsync -avx -e "ssh ${SSH_OPTS}" --delete-during --exclude "lost+found" "${VOLROOT}/${VOL}/" "root@nas.default:/tank/Volumes/${VOL}/"
  done
  echo Sync Complete
done
