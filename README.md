# NexusWave AI Labs, OAU Teknokent - SoHo Network Design

## Project Summary

This project is a SoHo network simulation representing the office network infrastructure of **NexusWave AI Labs**, an artificial intelligence startup based at **OAU**.

![image](https://github.com/user-attachments/assets/839c2fa9-c521-4eea-979b-41bbb427a2f7)

![image](https://github.com/user-attachments/assets/e799d939-6d15-465c-a988-d8633c74c60f)

## Key Features

Unlike the [Campus Network project](https://github.com/onurakay/oau-campus-network) I worked on before, this project allowed me to dig deeper into the details as it is a smaller and focused office network.

- **VLAN Segmentation** (Staff, Guest, IoT, Servers, VoIP, Management, Blackhole)
- **Inter-VLAN Routing with L3 Switch (OFFICE-CORE) 
- **Web, DHCP, NTP, SYSLOG, TFTP servers in Server VLAN (vlan40)**
![image](https://github.com/user-attachments/assets/1b737c43-283d-4b94-8bb3-689986afa25e)
- **Port Security, BPDU Guard, Blackhole VLAN (vlan333) etc. measures and ACLs were used to ensure LAN security and compliance with ISO 27001 Information Security Management System standards. ** 
- **Management access via SSH only (via MGMT VLAN (vlan99))** 
- **NAT + Static Port Forwarding** (for web server) 
- **OSPF**, for routing between routers
- **Wi-Fi infrastructure** configured via web interface via Cisco WLC 2504 and integrated into VLANs with separate SSIDs.
- Guest Wi-Fi & BYOD VLANs**, fully isolated with ACL 
- **Allow access to servers and critical systems only from specific VLANs** 
- **Blackhole VLAN (333)** - for disabled ports

## Network Topology

