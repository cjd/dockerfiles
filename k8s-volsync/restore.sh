#!/bin/sh
set -e
# Fix for permissions when pod not running as root (https://github.com/kubernetes/kubernetes/issues/57923)
cp /root/.ssh/id_rsa /root
chmod 0400 /root/id_rsa

SSH_OPTS='-q -p 12000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /root/id_rsa'

echo "Checking for the existing data"
cd /k8s || exit
for PV in */*; do
  if [ -d "$PV" ]; then
    echo "Checking ${PV}"
    # Check if directory empty
    if [ ! "$(ls -A "${PV}" | grep -v '^lost+found$')" ]; then
      BACKUP_STATUS=$(ssh $SSH_OPTS root@nas.default "if [ -d '/tank/Volumes/${PV}' ]; then echo exists; else echo missing; fi")
      if [ "$BACKUP_STATUS" = "exists" ]; then
        echo "Restoring ${PV} from tank"
        rsync -avX -e "ssh $SSH_OPTS" --delete-during --exclude "lost+found" "root@nas.default:/tank/Volumes/${PV}/" "/k8s/${PV}/"
      else
        echo "No backup found on tank for ${PV}. Starting fresh"
      fi
    else
      echo "${PV} data already exists. Skipping sync"
    fi
  fi
done
echo "  >> Data loaded"
