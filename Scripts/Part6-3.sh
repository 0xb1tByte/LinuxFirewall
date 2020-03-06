#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"
ServerIP="192.168.101.2"
Client_Net_Interface="enp0s8"
Server_Net_Interface="enp0s9"

# flush all chains
$iptablesPATH -F

# Create a new chain called LOGGING2
$iptablesPATH -N LOGGING2
$iptablesPATH -A LOGGING2 -j LOG -m hashlimit --hashlimit 1/sec --hashlimit-mode dstport,srcip --hashlimit-name hosts --log-prefix "LOGDROPPED2:dropped!!" --log-level 6
$iptablesPATH -A LOGGING2 -j DROP

# Accept the packets that are related to the connectins established by the server 
$iptablesPATH -A FORWARD -i $Client_Net_Interface -d $ServerIP --match state --state ESTABLISHED,RELATED --jump ACCEPT

# Accept connection on 22 port (SSH)
$iptablesPATH -A FORWARD -i $Client_Net_Interface -o $Server_Net_Interface -d $ServerIP -p tcp --dport 22 -j ACCEPT 

# Default Deny to outgoing connection to 192.168.101.2 on all services
$iptablesPATH -A FORWARD -i $Client_Net_Interface -o $Server_Net_Interface -d $ServerIP -j LOGGING2


# Save Settings
$iptablesSavePATH
