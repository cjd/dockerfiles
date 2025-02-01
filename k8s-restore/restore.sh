#!/bin/sh
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
    if [ ! "$(ls -A "${PV}" | grep -v lost+found)" ]; then
      echo "Restoring ${PV} from tank"
      rsync -av -e "ssh $SSH_OPTS" --delete-during root@nas.default:/tank/Volumes/${PV}/ /k8s/${PV}/
    fi
  fi
done
echo "  >> Data loaded"
