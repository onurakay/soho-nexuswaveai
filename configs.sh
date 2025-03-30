---------------------------- SW1 ----------------------------
en
conf t
no ip domain-lookup
hostname SW1

vlan 10
name STAFF
vlan 30
name WIFI_USER
vlan 40
name SERVERS
vlan 50
name VOIP
vlan 99
name MGMT
vlan 333
name BLACKHOLE

interface gi 0/1
description SW1 to OFFICE-CORE
switchport mode trunk

interface range fa 0/1-2
description Staff PCs - VLAN 10
switchport mode access
switchport access vlan 10
spanning-tree portfast
spanning-tree bpduguard enable

interface fa 0/3
description Management PCs - VLAN 99
switchport mode access
switchport access vlan 99
spanning-tree portfast
spanning-tree bpduguard enable

interface fa 0/20
description IP Phones - VLAN 50 (Voice)
switchport mode access
switchport voice vlan 50
spanning-tree portfast
spanning-tree bpduguard enable

interface fa 0/21
description WIFI_USER - VLAN 30
switchport mode access
switchport access vlan 30
switchport port-security
spanning-tree portfast
spanning-tree bpduguard enable

interface range fa 0/4-19
switchport mode access
switchport access vlan 333
spanning-tree bpduguard enable
shutdown

interface range fa 0/22-24
switchport mode access
switchport access vlan 333
spanning-tree bpduguard enable
shutdown

interface vlan99
ip address 172.16.99.5 255.255.255.240
no shutdown
ip default-gateway 172.16.99.1

exit

enable secret Mtx!2025#CoreNet

line console 0
password Mtx!2025#CoreNet
login 
exit

ip domain-name nexuswave.local
crypto key generate rsa
2048
username netmanadmin password A1rNexus#Lab2025
line vty 0 4
login local
transport input ssh

service password-encryption

ip access-list standard SSH_ONLY_MGMT
 permit 172.16.99.0 0.0.0.15
 deny any

line vty 0 4
 access-class SSH_ONLY_MGMT in

ntp server 172.16.40.2
logging 172.16.40.2
logging trap debugging
service timestamps log datetime msec
service timestamps debug datetime msec
copy running-config tftp


---------------------------- SW2 ----------------------------
en
conf t
no ip domain-lookup
hostname SW2

vlan 20
name IOT
vlan 31
name WIFI_GUEST
vlan 36
name DEVICE_GUEST
vlan 40
name SERVERS
vlan 99
name MGMT
vlan 333
name BLACKHOLE

interface range gi 0/1
description SW2 to OFFICE-CORE
switchport mode trunk

interface range fa 0/1-3
description IoT Devices - VLAN 20
switchport mode access
switchport access vlan 20
spanning-tree portfast
spanning-tree bpduguard enable

interface fa 0/20
description IP Security Cameras - VLAN 20
switchport mode access
switchport access vlan 20
spanning-tree portfast
spanning-tree bpduguard enable

interface fa 0/21
description WIFI_GUEST - VLAN 31
switchport mode access
switchport access vlan 31
switchport port-security
spanning-tree portfast
spanning-tree bpduguard enable

interface range fa 0/4-5
description Guest Devices (Open) - VLAN 36
switchport mode access
switchport access vlan 36
spanning-tree portfast
spanning-tree bpduguard enable

interface range fa 0/6-10
description Guest Devices (Closed, reserved) - VLAN 36
switchport mode access
switchport access vlan 36
spanning-tree portfast
spanning-tree bpduguard enable
shutdown

interface range fa 0/11-19
switchport mode access
switchport access vlan 333
spanning-tree bpduguard enable
shutdown

interface range fa 0/22-24
switchport mode access
switchport access vlan 333
spanning-tree bpduguard enable
shutdown

interface vlan99
ip address 172.16.99.6 255.255.255.240
no shutdown
ip default-gateway 172.16.99.1

exit

enable secret Mtx!2025#CoreNet

line console 0
password Mtx!2025#CoreNet
login 
exit

ip domain-name nexuswave.local
crypto key generate rsa
2048
username netmanadmin password A1rNexus#Lab2025
line vty 0 4
login local
transport input ssh

service password-encryption

ip access-list standard SSH_ONLY_MGMT
 permit 172.16.99.0 0.0.0.15
 deny any

line vty 0 4
 access-class SSH_ONLY_MGMT in

ntp server 172.16.40.2
logging 172.16.40.2
logging trap debugging
service timestamps log datetime msec
service timestamps debug datetime msec
copy running-config tftp


---------------------------- OFFICE-CORE ----------------------------
en
conf t
no ip domain-lookup
hostname OFFICE-CORE

vlan 10
name STAFF
vlan 20
name IOT
vlan 30
name WIFI
vlan 31
name WIFI_GUEST
vlan 36
name DEVICE_GUEST
vlan 40
name SERVERS
vlan 50
name VOIP
vlan 99
name MGMT
vlan 333
name BLACKHOLE

ip routing

interface GigabitEthernet0/1
no switchport
description Link to OFFICE-EDGE
ip address 192.168.2.1 255.255.255.252
no shutdown

ip route 0.0.0.0 0.0.0.0 192.168.2.2

interface fa 0/1
description OFFICE-CORE to SW1
switchport mode trunk

interface fa 0/3
description OFFICE-CORE to SW2
switchport mode trunk

interface fa 0/21
description OFFICE-CORE to WLC-OFFICE
switchport mode access
switchport access vlan 30

interface range fa 0/12-14
description OFFICE-CORE to SERVERS
switchport mode access
switchport access vlan 40

interface range fa 0/5-11
switchport mode access
switchport access vlan 333
shutdown

interface range fa 0/15-20
switchport mode access
switchport access vlan 333
shutdown

interface range fa 0/22-24
switchport mode access
switchport access vlan 333
shutdown

interface vlan10
ip address 172.16.10.1 255.255.255.0
ip helper-address 172.16.40.2
no shutdown

interface vlan20
ip address 172.16.20.1 255.255.255.240
ip helper-address 172.16.40.2
no shutdown

interface vlan30
ip address 172.16.30.1 255.255.255.0
ip helper-address 172.16.40.2
no shutdown

interface vlan31
ip address 172.16.31.1 255.255.255.0
ip helper-address 172.16.40.2
no shutdown

interface vlan36
ip address 172.16.36.1 255.255.255.224
ip helper-address 172.16.40.2
no shutdown

interface vlan40
ip address 172.16.40.1 255.255.255.240
no shutdown

interface vlan50
ip address 172.16.50.1 255.255.255.248
ip helper-address 172.16.40.2
no shutdown

interface vlan99
ip address 172.16.99.1 255.255.255.240
no shutdown

exit

ip access-list extended ACL_GUEST_RESTRICT
 remark --- BLOCK GUEST USERS FROM ACCESSING INTERNAL VLANs ---
 deny ip 172.16.31.0 0.0.0.255 172.16.10.0 0.0.0.255
 deny ip 172.16.31.0 0.0.0.255 172.16.20.0 0.0.0.15
 deny ip 172.16.31.0 0.0.0.255 172.16.30.0 0.0.0.255
 deny ip 172.16.31.0 0.0.0.255 172.16.40.0 0.0.0.15
 deny ip 172.16.31.0 0.0.0.255 172.16.99.0 0.0.0.15
 permit ip any any
interface vlan31
 ip access-group ACL_GUEST_RESTRICT in

ip access-list extended ACL_DEVICE_GUEST_RESTRICT
 remark --- BLOCK PERSONAL DEVICES FROM ACCESSING STAFF/CORE NETWORK ---
 deny ip 172.16.36.0 0.0.0.31 172.16.10.0 0.0.0.255
 deny ip 172.16.36.0 0.0.0.31 172.16.20.0 0.0.0.15
 deny ip 172.16.36.0 0.0.0.31 172.16.30.0 0.0.0.255
 deny ip 172.16.36.0 0.0.0.31 172.16.40.0 0.0.0.15
 deny ip 172.16.36.0 0.0.0.31 172.16.99.0 0.0.0.15
 permit ip any any
interface vlan36
 ip access-group ACL_DEVICE_GUEST_RESTRICT in

ip access-list extended ACL_IOT_OUTBOUND
 remark --- BLOCK IOT FROM INITIATING TO STAFF AND SERVERS ---
 deny ip 172.16.20.0 0.0.0.15 172.16.10.0 0.0.0.255
 deny ip 172.16.20.0 0.0.0.15 172.16.40.0 0.0.0.15
 deny ip 172.16.20.0 0.0.0.15 172.16.99.0 0.0.0.15
 permit ip any any
interface vlan20
 ip access-group ACL_IOT_OUTBOUND in

ip access-list extended ACL_MGMT_SECURE
 remark --- ALLOW MGMT-PC ONLY ---
 permit ip host 172.16.99.3 172.16.99.0 0.0.0.15
 remark --- BLOCK ALL OTHERS ---
 deny ip any 172.16.99.0 0.0.0.15
 permit ip any any
interface vlan99
 ip access-group ACL_MGMT_SECURE in

enable secret Mtx!2025#CoreNet

line console 0
password Mtx!2025#CoreNet
login 
exit

ip domain-name nexuswave.local
crypto key generate rsa
2048
username netmanadmin password A1rNexus#Lab2025
line vty 0 4
login local
transport input ssh

service password-encryption

ip access-list standard SSH_ONLY_MGMT
 permit 172.16.99.0 0.0.0.15
 deny any

line vty 0 4
 access-class SSH_ONLY_MGMT in

ntp server 172.16.40.2
logging 172.16.40.2
logging trap debugging
service timestamps log datetime msec
service timestamps debug datetime msec
copy running-config tftp

---------------------------- OFFICE-EDGE ----------------------------
en
configure terminal
hostname OFFICE-EDGE
no ip domain-lookup

interface GigabitEthernet0/1
 description Link to OFFICE-CORE
 ip address 192.168.2.2 255.255.255.252
 no shutdown

interface GigabitEthernet0/3/0
 description Link to TEKNOKENT-CORE
 ip address 10.235.20.2 255.255.255.252
 no shutdown

router ospf 1
network 10.235.20.0 0.0.0.3 area 0
network 172.16.0.0 0.0.255.255 area 0

ip route 172.16.0.0 255.255.0.0 192.168.2.1

exit

enable secret Mtx!2025#CoreNet

line console 0
password Mtx!2025#CoreNet
login 
exit

ip domain-name nexuswave.local
crypto key generate rsa
2048
username netmanadmin password A1rNexus#Lab2025
line vty 0 4
login local
transport input ssh

service password-encryption

ip access-list standard SSH_ONLY_MGMT
 permit 172.16.99.0 0.0.0.15
 deny any

line vty 0 4
 access-class SSH_ONLY_MGMT in




---------------------------- TEKNOKENT-CORE ----------------------------
en
conf t
hostname TEKNOKENT-CORE
no ip domain-lookup

interface GigabitEthernet0/2/0
 description Link to OFFICE-EDGE
 ip address 10.235.20.1 255.255.255.252
 no shutdown

interface Serial0/3/0
 description Link to ISP
 ip address 203.0.113.2 255.255.255.252
 encapsulation ppp
 no shutdown
 
access-list 1 permit 172.16.10.0 0.0.0.255

interface GigabitEthernet0/2/0
ip nat inside

interface Serial0/3/0
ip nat outside

ip nat inside source list 1 interface Serial0/3/0 overload

router ospf 1
network 10.235.20.0 0.0.0.3 area 0
default-information originate

ip route 0.0.0.0 0.0.0.0 203.0.113.1
ip route 172.16.0.0 255.255.0.0 10.235.20.2

ip nat inside source static tcp 172.16.40.4 80 203.0.113.2 80
ip nat inside source static tcp 172.16.40.4 443 203.0.113.2 443




---------------------------- ISP ----------------------------
enable
conf t
hostname ISP
no ip domain-lookup

interface Serial0/3/0
 description Link to TEKNOKENT-CORE
 ip address 203.0.113.1 255.255.255.252
 encapsulation ppp
 no shutdown

interface Gi 0/0
 description Link to Google
 ip address 8.0.0.1 255.0.0.0
 no shutdown

 router ospf 1
network 203.0.113.0 0.0.0.3 area 0




---------------------------- GOOGLE-VSM ----------------------------
en
configure terminal
hostname GOOGLE-VSM

vlan 2
 name MGMT

interface Vlan2
 ip address 8.0.0.10 255.255.255.0
 no shutdown

interface FastEthernet0/24
 description Link to ISP
 switchport mode access
 no shutdown

end
