#!/bin/sh
(while :;do echo Forwarding port 8112; socat -d tcp-listen:8112,fork,reuseaddr tcp-connect:vpn:8112; sleep 10; done) &
(while :;do echo Forwarding port 8081; socat -d tcp-listen:8081,fork,reuseaddr tcp-connect:vpn:8081; sleep 10; done) &
(while :;do echo Forwarding port 7878; socat -d tcp-listen:7878,fork,reuseaddr tcp-connect:vpn:7878; sleep 10; done) &
(while :;do echo Forwarding port 1080; socat -d tcp-listen:1080,fork,reuseaddr tcp-connect:vpn:1080; sleep 10; done) &
(while :;do echo Forwarding port 8090; socat -d tcp-listen:8090,fork,reuseaddr tcp-connect:vpn:8090; sleep 10; done) &
(while :;do echo Forwarding port 5000; socat -d tcp-listen:5000,fork,reuseaddr tcp-connect:vpn:5000; sleep 10; done) &
(while :;do echo Forwarding port 5299; socat -d tcp-listen:5299,fork,reuseaddr tcp-connect:vpn:5299; sleep 10; done) &
(while :;do echo Forwarding port 8989; socat -d tcp-listen:8989,fork,reuseaddr tcp-connect:vpn:8989; sleep 10; done) &
(while :;do echo Forwarding port 9117; socat -d tcp-listen:9117,fork,reuseaddr tcp-connect:vpn:9117; sleep 10; done) &
(while :;do echo Forwarding port 58846 for deluge; socat -d tcp-listen:58846,fork,reuseaddr tcp-connect:vpn:58846; sleep 10; done) &
(while :;do echo Forwarding port 1080u; socat -d udp-recvfrom:1080,fork udp-sendto:vpn:1080; sleep 10; done)

