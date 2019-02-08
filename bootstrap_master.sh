#!/bin/sh
 
# Run on VM to bootstrap Puppet Master server
 
# Configure /etc/hosts file
echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.65.100  master.puppet.vm  master" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.65.101  node1.puppet.vm  node1" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "192.168.65.102  node2.puppet.vm  node2" | sudo tee --append /etc/hosts 2> /dev/null


#install git

apt-get -y install git


#add a hack to enable non-interactive clonning
touch /root/.ssh/known_hosts
ssh-keygen -F github.com || ssh-keyscan github.com >>/root/.ssh/known_hosts

mkdir -p /opt/puppet-dev
cd /opt/puppet-dev
git clone -b marcin_dev --single-branch git@github.com:moolibdensplk/control_repo.git


echo "RUNNING Shahzad script part"
sleep 10


# Fixing the '/var/lib/dpkg/lock' error when PE is being installed.
echo 'Fix locking error'
if [ -d /etc/systemd/system/apt-daily.timer.d ]; then
    echo 'Directory exists'
    else mkdir -p /etc/systemd/system/apt-daily.timer.d
fi
if [ -f /etc/systemd/system/apt-daily.timer.d/apt-daily.timer.conf ]; then
    echo 'File exists'
    else touch /etc/systemd/system/apt-daily.timer.d/apt-daily.timer.conf
fi

echo '[Timer]' >> /etc/systemd/system/apt-daily.timer.d/apt-daily.timer.conf
echo 'Persistent=false' >> /etc/systemd/system/apt-daily.timer.d/apt-daily.timer.conf
echo 'sleeping for 10 seconds'
sleep 10

# Download Puppet Entperprise and extract it.
wget https://pm.puppetlabs.com/puppet-enterprise/2018.1.7/puppet-enterprise-2018.1.7-ubuntu-16.04-amd64.tar.gz
tar xvfz puppet-enterprise-2018.1.7-ubuntu-16.04-amd64.tar.gz

# Create a Puppet pe.conf file.
touch pe.conf
echo '{' >> pe.conf
echo '"console_admin_password"': '"puppet"' >> pe.conf
echo '"puppet_enterprise::puppet_master_host"': '"master.puppet.vm"' >> pe.conf
echo '}' >> pe.conf

# Run Puppet installation
puppet-enterprise-2018.1.7-ubuntu-16.04-amd64/puppet-enterprise-installer -c pe.conf


# copy the Classification from the console (4 settings)
puppet_enterprise::profile::master :: code_manager_auto_configure 


