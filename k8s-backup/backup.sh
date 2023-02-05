#!/bin/bash
NS=$1
if [ -z "${NS}" ];then echo Namespace not set;exit;fi
SNAPSHOT_YAML="---
kind: VolumeSnapshot
apiVersion: snapshot.storage.k8s.io/v1
metadata:
  name: ##VOL##-snap
spec:
  volumeSnapshotClassName: longhorn-snapshot-vsc
  source:
    persistentVolumeClaimName: ##VOL##
"

PVC_YAML="---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: ##VOL##-snap-pvc
spec:
  storageClassName: longhorn
  dataSource:
    name: ##VOL##-snap
    kind: VolumeSnapshot
    apiGroup: snapshot.storage.k8s.io
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: ##SIZE##
"

JOB_YAML="---
kind: Job
apiVersion: batch/v1
metadata:
  name: rsync-backup
  labels:
    app: rsync-backup

spec:
  backoffLimit: 4
  template:
    metadata:
      labels:
        app: rsync-backup
    spec:
      restartPolicy: Never
      containers:
        - name: rsync-backup
          image: debenham/rsync
          command: ['sh', '-c', 'rsync -av --no-owner --no-group --delete-during /mnt/ /backupdir/; true']
          volumeMounts:
            - mountPath: /backupdir
              name: backupdir-vol
"
JOB_YAML_VOL="      volumes:
        - name: backupdir-vol
          nfs:
            server: 192.168.0.2
            path: /tank/Volumes"

mkdir snap 2>/dev/null
mkdir pvc 2>/dev/null
mkdir job 2>/dev/null
rm snap/* pvc/* job/* 2>/dev/null
VOLUMES=""
echo -en "$JOB_YAML" > job/backup-job.yml
while IFS="," read -r VOL SIZE
        do echo Backing up $VOL
        echo -en "$SNAPSHOT_YAML" | sed -e "s/##VOL##/${VOL}/g" -e "s/##SIZE##/${SIZE}/g" > snap/${VOL}-snap.yml
        echo -en "$PVC_YAML" | sed -e "s/##VOL##/${VOL}/g" -e "s/##SIZE##/${SIZE}/g" > pvc/${VOL}-pvc.yml
        echo -en "            - mountPath: /mnt/${VOL}\n              name: ${VOL}-vol\n" >> job/backup-job.yml
        VOLUMES="${VOLUMES}\n        - name: ${VOL}-vol\n          persistentVolumeClaim:\n            claimName: ${VOL}-snap-pvc"
done < <(kubectl get pvc -o json| jq -r '.items[] | [.metadata.name,.spec.resources.requests.storage] | @csv' | sed -e 's/"//g' | grep -v snap-pvc)
echo -en "$JOB_YAML_VOL" >> job/backup-job.yml
echo -en "/${NS}" >> job/backup-job.yml
echo -en "${VOLUMES}\n" >> job/backup-job.yml
if [ "${VOLUMES}" == "" ]; then exit;fi
kubectl delete -f pvc 2>/dev/null
kubectl delete -f snap 2>/dev/null
kubectl apply -f snap
kubectl apply -f pvc
kubectl apply -f job
sleep 10
while [ "`kubectl get job rsync-backup -o json | jq -r '.status.succeeded'`" != "1" ]; do sleep 10; done
kubectl get job rsync-backup
kubectl logs job/rsync-backup
kubectl delete -f job
kubectl delete -f pvc
kubectl delete -f snap
