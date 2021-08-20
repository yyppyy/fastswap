sip="10.10.10.221"
cip="10.10.10.201"


#enable ip
ip addr add $cip/32 dev ens9
ifconfig ens9 mtu 9000
ifconfig ens9 up

ip route add 10.10.10.0/24 dev ens9
arp -i ens9 -s $sip 04:3f:72:a2:b7:3a
#arp -i ens9 -s 10.10.10.212 04:3f:72:a2:b4:3b
ping -c 3 $sip  # switch vm

ibv_devinfo


#setup fastswap
cd ~/fastswap/drivers
rm fastswap_rdma.ko
rm fastswap.ko
make BACKEND=RDMA
sudo rmmod fastswap.ko
sudo rmmod fastswap_rdma.ko
sudo insmod fastswap_rdma.ko sport=50000 sip="10.10.10.221" cip="10.10.10.201" nq=8
sudo insmod fastswap.ko
