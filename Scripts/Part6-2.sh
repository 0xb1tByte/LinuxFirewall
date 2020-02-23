#!/bin/bash

iptablesPATH=”/sbin/iptables”
iptablesSavePATH=”/sbin/iptables-save”
ServerIP=”192.168.101.2”

# flush all chains
$iptablesPATH -F

# Create a new chain called LOGGING
$iptablesPATH -N LOGGING
$iptablesPATH -A LOGGING -j LOG --m hashlimit --hashlimit 1/sec --hashlimit-mode dstip,dstport,srcip,srcport --log-prefix "LOG: Connection to 80 dropped" --log-level 6
$iptablesPATH -A LOGGING -j DROP

 # Block outgoing connection to 192.168.101.2 on port 80 
$iptablesPATH -A FORWARD -d $ServerIP -p tcp –dport 80 -j LOGGING

# Save Settings
$iptablesSavePATH
