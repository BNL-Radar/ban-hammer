#!/bin/sh

# Create the ipset list
ipset -N russia hash:net

# remove any old list that might exist from previous runs of this script
rm /etc/uzone

# Pull the latest IP set for Russia
cd /etc
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ru.zone

# Add each IP address from the downloaded list into the ipset 'russia'
for i in $(cat /etc/ru.zone ); do ipset -A russia $i; done

# Restore iptables
/sbin/iptables-restore < /etc/iptables.firewall.rules
