#!/bin/bash

iptablesPATH=”/sbin/iptables”
iptablesSavePATH=”/sbin/iptables-save”

# flush all chains
$iptablesPATH -F 
# Default Deny 
$iptablesPATH -P INPUT DROP
# Exception to Default Deny
$iptablesPATH -A INPUT -p tcp --dport 22 -j ACCEPT # SSH
# Save Settings
$iptablesSavePATH
