#!/bin/ash
ssh-honeypot -r /ssh-honeypot/ssh-honeypot.rsa -p 2000 -u 1000
echo "SSH Honeypot is Running..."
exec "$@"

