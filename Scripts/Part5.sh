#!/bin/bash

iptablesPATH="/sbin/iptables"
iptablesSavePATH="/sbin/iptables-save"
ServerIP="192.168.101.2"
ClientIP="192.168.100.2"
Server-Net="192.168.101.0/24" 
Client-Net="192.168.100.0/24"
Client-Net_Interface="enp0s3"
Server-Net_Interface="enp0s8"
routerInterfaces="${Server-Net_Interface} ${Client-Net_Interface}"
PrivateIPs="10.0.0.0/8 172.16.0.0/12 192.168.0.0/16"

# flush all chains
$iptablesPATH -F 

# DROP all packet that are coming from routerInterfaces with source and destination as $ServerIP 
for interface in $routerInterfaces
do
  $iptablesPATH -A FORWARD -i $interface -d $ServerIP -s  $ServerIP -j DROP
  $iptablesPATH -A FORWARD -o $interface -d $ServerIP -s  $ServerIP -j DROP
done

# DROP Private IPs Packets
for ip in $PrivateIPs
do
  for interface in $routerInterfaces
  do
  $iptablesPATH -A FORWARD -o $interface  -s $ip -j DROP
  $iptablesPATH -A FORWARD -i $interface  -s $ip -j DROP
  done
done

# DROP all packet going to Server except packet that are coming from Client Networks
$iptablesPATH -A FORWARD -d $ServerIP -s !$Client-Net -j DROP

# Prevent the server from sending spoofed packets 
$iptablesPATH -A FORWARD -o $Server-Net_Interface -s !$ServerIP -j DROP


# Save Settings
$iptablesSavePATH
