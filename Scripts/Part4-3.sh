#!/bin/bash

iptablesPATH=”/sbin/iptables”
iptablesSavePATH=”/sbin/iptables-save”
ServerIP=”192.168.101.2”

# flush all chains
$iptablesPATH -F 
# Default Deny to outgoing connection to 192.168.101.2 on all services
$iptablesPATH -A FORWARD -d $ServerIP -j DROP
# Exception to previous policy 
$iptablesPATH -A FORWARD -d $ServerIP  -p tcp --dport 22 -j ACCEPT # SSH
# Save Settings
$iptablesSavePATH
