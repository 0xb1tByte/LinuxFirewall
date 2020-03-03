#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"
Client_Net_Interface="enp0s8"
Server_Net_Interface="enp0s9"

# flush all chains
$iptablesPATH -F 

# Drop all FORWARD packet 
$iptablesPATH -P FORWARD DROP

# Exception to last policy , allow trafic from Server_Net_Interface => Client_Net_Interface
$iptablesPATH -A FORWARD -i $Server_Net_Interface -o $Client_Net_Interface -j ACCEPT

# Exception to last policy , allow trafic from Client_Net_Interface => Server_Net_Interface 
$iptablesPATH -A FORWARD -i $Client_Net_Interface -o $Server_Net_Interface -j ACCEPT

# Save Settings
$iptablesSavePATH
