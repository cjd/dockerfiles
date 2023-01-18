#!/bin/sh
echo "Checking for the existing data"
mkdir -p /backup
mount -o nolock 192.168.0.2:/tank/Volumes/$NS /backup
cd /mnt
for PV in *
        do if [ ! -f /mnt/${PV}/.restored -o -f /mnt/${PV}/.force_restore ]
                then rsync -av /backup/${PV}-pvc/ /mnt/${PV}/
        fi
done
echo "  >> Data loaded"
