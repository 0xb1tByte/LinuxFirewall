#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"
ServerIP=192.168.101.2

# flush all chains
$iptablesPATH -F 
# Block outgoing connection to 192.168.101.2 on port 80 
$iptablesPATH -A FORWARD -d $ServerIP -p tcp --dport 80 -j DROP
# Save Settings
$iptablesSavePATH
