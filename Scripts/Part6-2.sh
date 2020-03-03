#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"
ServerIP="192.168.101.2"
Client_Net_Interface="enp0s8"
Server_Net_Interface="enp0s9"

# flush all chains
$iptablesPATH -F


# Create a new chain called LOGGING
$iptablesPATH -N LOGGING
$iptablesPATH -A LOGGING -j LOG -m hashlimit --hashlimit 1/sec --hashlimit-mode dstip,dstport,srcip,srcport --hashlimit-name hosts --log-prefix "LOGDROPPED: Connection to 80 dropped" --log-level 6
$iptablesPATH -A LOGGING -j DROP

 # Block incoming connection to 192.168.101.2 on port 80 
$iptablesPATH -A FORWARD -i $Client_Net_Interface -o $Server_Net_Interface -d $ServerIP -p tcp --dport 80 -j LOGGING
 


# Save Settings
$iptablesSavePATH
