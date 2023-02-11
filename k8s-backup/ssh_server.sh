#!/bin/sh
ssh-keygen -A
/usr/sbin/sshd -D -e -p 12000 -o PasswordAuthentication=no -o StrictModes=no
