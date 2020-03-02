#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"

# flush all chains
$iptablesPATH -F 
# block Access to Port 80
$iptablesPATH -A INPUT -p tcp --dport 80 -j REJECT
# Save Settings
$iptablesSavePATH
