Quick container to build a hosts file from doing a reverse-dns lookup of a subnet

Takes three environment variables:\
NET for the first 3 components of the subnet\
DNS to list your preferred DNS server to query
LOCALDOMAIN to name your local domain

This is used in conjunction with a dual-pihole setup where your main Pihole runs on one system (serving DHCP and DNS) and gives out a secondary DNS server.\
On the secondary DNS server you also run pihole with this script generating a hosts file so that it will respond properly for local addresses as well\

    version: '3.4'
    services:
      pihole:
        container_name: pihole
        hostname: pihole
        image: pihole/pihole
        restart: always
        network_mode: host
        ports:
          - "53:53/tcp"
          - "53:53/udp"
          - "67:67/udp"
          - "2080:2080/tcp"
          - "2443:443/tcp"
        environment:
          TZ: 'Australia/Sydney'
          WEBPASSWORD: 'admin'
          SERVER_IP: '192.168.0.8'
          VIRTUAL_HOST: home.example.com
          WEB_PORT: 2080
          INTERFACE: eno1
        volumes:
          - ./dns2hosts/hosts:/etc/hosts:ro
          - ./pihole/etc-pihole/:/etc/pihole/
          - ./pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/
        cap_add:
          - NET_ADMIN
      dns2hosts:
        container_name: dns2hosts
        image: debenham/dns2hosts
        restart: always
        environment:
          DNS: 192.168.0.9
          NET: 192.168.0
          LOCALDOMAIN: lan
        volumes:
          - ./dns2hosts/hosts:/hosts
