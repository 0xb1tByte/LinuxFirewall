#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"

# flush all chains
$iptablesPATH -F 
# Default Deny 
$iptablesPATH -P INPUT DROP
# Exception to Default Deny
$iptablesPATH -A INPUT -p tcp --dport 22 -j ACCEPT # SSH
# Accept the packets that are related to the connectins established by the server 
$iptablesPATH -A INPUT --match state --state ESTABLISHED,RELATED --jump ACCEPT
# Save Settings
$iptablesSavePATH
