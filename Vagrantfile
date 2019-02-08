# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant/ui'
require 'yaml'

UI = Vagrant::UI::Colored.new

## User Config
##############################################

class UserConfig
  attr_accessor :box
  attr_accessor :box_url
  attr_accessor :box_version
  attr_accessor :machine_config_path

  def self.from_env
    c = new
    c.box                  = ENV.fetch(env_var('box'), 'bento/ubuntu-16.04')
    c.box_url              = ENV.fetch(env_var('box_url'), 'https://atlas.hashicorp.com/bento/ubuntu-16.04')
    #c.box_version          = ENV.fetch(env_var('box_version'), '= 2.3.1')
    c.machine_config_path  = ENV.fetch(env_var('machine_config_path'), 'VagrantConfig.yml')
    c
  end

  def self.env_var(field)
    "OR_#{field.to_s.upcase}"
  end

  # validate required fields and files
  def validate
    errors = []

    # validate required fields
    required_fields = [
      :box,
      :box_url,
      :box_version,
      :machine_config_path
    ]
    required_fields.each do |field_name|
      field_value = send(field_name.to_sym)
      if field_value.nil? || field_value.empty?
        errors << "Missing required attribute: #{field_name}"
      end
    end

    raise ValidationError, errors unless errors.empty?

    # validate required files
    required_files = []
    required_files << :machine_config_path if !@machine_config_path.empty?

    required_files.each do |field_name|
      file_path = send(field_name.to_sym)
      unless File.file?(file_path)
        errors << "File not found: '#{file_path}'. Ensure that the file exists or reconfigure its location (export #{UserConfig.env_var(field_name)}=<value>)."
      end
    end

    raise ValidationError, errors unless errors.empty?
  end
end

class ValidationError < StandardError
  def initialize(list=[], msg="Validation Error")
    @list = list
    super(msg)
  end

  def publish
    UI.error 'Errors:'
    @list.each do |error|
      UI.error "  #{error}"
    end
    exit 2
  end
end

## Plugin Validation
##############################################

def validate_plugins
  required_plugins = [
    'vagrant-hostmanager'
  ]
  missing_plugins = []

  required_plugins.each do |plugin|
    unless Vagrant.has_plugin?(plugin)
      missing_plugins << "The '#{plugin}' plugin is required. Install it with 'vagrant plugin install #{plugin}'"
    end
  end

  unless missing_plugins.empty?
    missing_plugins.each { |x| UI.error x }
    return false
  end

  true
end

# path to the provision shell scripts
def provision_script_path(type)
  "./vagrant_provision/bin/#{type}.sh"
end


## One Time Setup
##############################################

Vagrant.require_version '>= 1.9.1'

begin
  UI.info 'Validating Plugins...'
  validate_plugins || exit(1)

  UI.info 'Validating User Config...'
  user_config = UserConfig.from_env
  user_config.validate

  UI.info 'Validating Machine Config...'
  machine_types = YAML.load_file(Pathname.new(user_config.machine_config_path).realpath)

rescue ValidationError => e
  e.publish
end

UI.info 'Configuring VirtualBox Host-Only Network...'
# configure vbox host-only network
system(provision_script_path('vbox-network'))


## VM Creation & Provisioning
##############################################

Vagrant.configure(2) do |config|

  # configure vagrant-hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false

  config.ssh.username = "root"
  config.ssh.password = "vagrant"

#  # Avoid random ssh key for demo purposes
#  config.ssh.insert_key = false

#  # Vagrant Plugin Configuration: vagrant-vbguest
#  if Vagrant.has_plugin?('vagrant-vbguest')
#    # enable auto update guest additions
#    config.vbguest.auto_update = true
#  end

  machine_types.each do |name, machine_type|
    config.vm.define name do |machine|
      machine.vm.hostname = "#{name}.dev.splunk.com"

      # custom hostname aliases
      if machine_type['aliases']
        machine.hostmanager.aliases = machine_type['aliases'].join(' ').to_s
      end

      # allow explicit nil values in the machine_type to override the defaults
      machine.vm.box = machine_type.fetch('box', user_config.box)
      machine.vm.box_url = machine_type.fetch('box-url', user_config.box_url)
      machine.vm.box_version = machine_type.fetch('box-version', user_config.box_version)

      machine.vm.provider 'virtualbox' do |v, override|
        v.name = machine.vm.hostname
        v.cpus = machine_type['cpus'] || 2
        v.memory = machine_type['memory'] || 2048
        v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']

        override.vm.network :private_network, ip: machine_type['ip']
      end

      if machine_type['type'] == 'puppetmaster'
      machine.vm.provision :puppet do |puppet|
       puppet.facter = {
        “fqdn” => "#{name}.dev.splunk.com",
       }
       #puppet.module_path = “modules”
       puppet.manifests_path = “sire/role/manifests”
       puppet.manifest_file = “puppetserver.pp” 
      end

     #example deployment of role specific manifest 
     if machine_type['type'] == 'webserver'
       machine.vm.provision :puppet do |puppet|
       puppet.facter = {
        “fqdn” => "#{name}.dev.splunk.com",
       }
       #puppet.module_path = “modules”
       puppet.manifests_path = “site/role/manifests”
       puppet.manifest_file = “webserver.pp”
      end
    end
  end
end
