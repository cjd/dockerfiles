#!/bin/sh
(while :;do echo Forwarding port 1080u for socks; socat -d udp-recvfrom:1080,fork udp-sendto:vpn:1080; sleep 10; done) &
(while :;do echo Forwarding port 1080 for socks; socat -d tcp-listen:1080,fork,reuseaddr tcp-connect:vpn:1080; sleep 10; done) &
(while :;do echo Forwarding port 7878 for radarr; socat -d tcp-listen:7878,fork,reuseaddr tcp-connect:vpn:7878; sleep 10; done) &
(while :;do echo Forwarding port 8112 for deluge; socat -d tcp-listen:8112,fork,reuseaddr tcp-connect:vpn:8112; sleep 10; done) &
(while :;do echo Forwarding port 8989 for sonarr; socat -d tcp-listen:8989,fork,reuseaddr tcp-connect:vpn:8989; sleep 10; done) &
(while :;do echo Forwarding port 9117 for jackett; socat -d tcp-listen:9117,fork,reuseaddr tcp-connect:vpn:9117; sleep 10; done) &
(while :;do echo Forwarding port 58846 for deluge; socat -d tcp-listen:58846,fork,reuseaddr tcp-connect:vpn:58846; sleep 10; done)
