# NexusWave AI Labs, OAU Teknokent - SoHo Network Design

This fictional project is a SoHo network simulation representing the office network infrastructure of **NexusWave AI Labs**, an artificial intelligence startup based at **OAU, Ankara**.

![image](https://github.com/user-attachments/assets/d4e26e67-a411-464a-8ab0-bfa114825c65)

## Features

Unlike the [Campus Network project](https://github.com/onurakay/oau-campus-network) I worked on before, this project allowed me to dig deeper into the details as it is a smaller and focused office network.

---

#### **VLAN Segmentation** (Staff, Guest, IoT, Servers, VoIP, Management, Blackhole)

---

#### **Inter-VLAN Routing with L3 Switch (OFFICE-CORE) 

---

#### **Web, DHCP, NTP, SYSLOG, TFTP servers in Server VLAN (vlan40)**
![image](https://github.com/user-attachments/assets/1376fb52-4417-4ae3-8874-96653c8fd52e)
![image](https://github.com/user-attachments/assets/b5e2b1ac-3f56-441c-90f8-1070fbb25cc5)
![image](https://github.com/user-attachments/assets/b8b68548-1f73-4fb9-89c9-35dd755e77f9)
![image](https://github.com/user-attachments/assets/dc7445b6-ac67-4dab-9a1e-1b792a6edcf7)

---

#### **Port Security, BPDU Guard, Blackhole VLAN (vlan333) etc. measures and ACLs were used to ensure LAN security and compliance with ISO 27001 Information Security Management System standards. **

---
  
### **Management access via SSH only (via MGMT VLAN (vlan99))**
```
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
```
### **NAT + Static Port Forwarding** (for web server)
Reached from outside of the network:
![image](https://github.com/user-attachments/assets/2d5a2335-bbc6-496a-b636-9e9a00dc9218)
### **OSPF**, for routing between routers
### **Wi-Fi infrastructure** configured via web interface via Cisco WLC 2504 and integrated into VLANs with separate SSIDs.  
<img src="https://github.com/user-attachments/assets/92991a16-6e6e-4540-acf5-7eb6220a3c1d" width="600">


#### **Note**: Due to limitations in Packet Tracer regarding wireless distance calculations, all wireless connecting to random APs. Here is how they work properly  
> ![image](https://github.com/user-attachments/assets/455e9c01-154f-42cd-9465-f1c25915b67b)  
> ![image](https://github.com/user-attachments/assets/57c7865b-3744-4639-8781-f1046ecb8aab)


### Guest Wi-Fi & BYOD VLANs**, fully isolated with ACL 
### **Allow access to servers and critical systems only from specific VLANs** 
### Necessary modules were installed on the devices.
![image](https://github.com/user-attachments/assets/c5f4d3af-65cb-44cc-b017-16eaae5d86ed)
![image](https://github.com/user-attachments/assets/32ec5a6a-858e-45bc-98a2-a0fd8cf67e8e)
![image](https://github.com/user-attachments/assets/c49fed98-82cf-4649-a98f-52a8e79106f7)




## Network Topology

