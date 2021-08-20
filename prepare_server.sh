sip=10.10.10.221
cip=10.10.10.201

ip addr add ï$sip/32 dev ens9
ifconfig ens9 mtu 9000
ifconfig ens9 up

ip route add 10.10.10.0/24 dev ens9
arp -i ens9 -s $cip 04:3f:72:a2:b4:a2
ping -c 3 $cip

ibv_devinfo

cd ~/fastswap/farmemserver
make
./rmserver 50000
