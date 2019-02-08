# vi: set ft=ruby :

# Builds Puppet Master and multiple Puppet Agent Nodes using JSON config file
# Author: Gary A. Stafford

# read vm and chef configurations from JSON files
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node

    config.vm.define node_name do |config|
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port[':host'],
          guest: port[':guest'],
          id:    port[':id']
      end

      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values[':ip']

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_name]
      end

      machine.vm.provider 'shell' do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
      ssh_priv_key = File.readlines("#{Dir.home}/.ssh/id_rsa").first.strip
      s.inline = <<-SHELL
         echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
         sudo bash -c "echo #{ssh_pub_key} >> /root/.ssh/authorized_keys"
         echo #{ssh_pub_key} >> /home/vagrant/.ssh/id_rsa.pub
         echo #{ssh_priv_key} >> /home/vagrant/.ssh/id_rsa
         sudo bash -c "echo #{ssh_priv_key} >> /home/root/.ssh/id_rsa"
        SHELL
      end

      config.vm.provision :shell, :path => node_values[':bootstrap']
    end
  end
end
