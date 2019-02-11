#!/bin/sh

# Configure /etc/hosts file
echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.65.100  master.puppet.vm  master" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.65.101  node1.puppet.vm  node1" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.65.102  node2.puppet.vm  node2" | sudo tee --append /etc/hosts 2> /dev/null

# Add agent section to /etc/puppet/puppet.conf
echo "" && echo "[agent]\nserver=master.puppet.vm" | sudo tee --append /etc/puppet/puppet.conf 2> /dev/null

#Install PuppetAgent from Puppet-PE Master Server
curl -k https://master.puppet.vm:8140/packages/current/install.bash | sudo bash

