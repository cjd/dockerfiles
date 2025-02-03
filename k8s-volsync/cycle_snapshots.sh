#!/bin/bash
# Quick snapshot of k8s volumes first
YESTERDAY=$(TZ="UTC+14" date "+%Y-%m-%d")
zfs snapshot "tank/Volumes@${YESTERDAY}"

# Clean up to only have last week of daily snapshots, then once per week, then once per month
for DATE in $(zfs list -t all |grep "@20"|sed -e 's/^.*@\([0-9-]*\) .*$/\1/g'|sort -u|head -n -7)
    do KEEP=$(date -d "$DATE" +%u)
    if [ "$KEEP" -ne 1 ]
        then for ZFS in $(zfs list -t all|grep "$DATE" | cut -f1 -d' ')
        do zfs destroy -v "$ZFS"
        done
    fi
done
for DATE in $(zfs list -t all |grep "@20"|sed -e 's/^.*@\([0-9-]*\) .*$/\1/g'|sort -u|head -n -14)
    do KEEP=$(echo "$DATE" | cut -f3 -d'-')
    if [ "$KEEP" -gt 7 ]
        then for ZFS in $(zfs list -t all|grep "$DATE" | cut -f1 -d' ')
        do zfs destroy -v "$ZFS"
        done
    fi
done
