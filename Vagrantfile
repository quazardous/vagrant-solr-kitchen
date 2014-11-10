# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos-65-x64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

  config.vm.network "forwarded_port", guest: 8983, host: 8983
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :shell, path: "provisioning/shell/bootstrap.sh"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "provisioning/puppet"
    puppet.module_path = "provisioning/puppet/modules"
    puppet.manifest_file  = "bootstrap.pp"
  end

  ['java.sh', 'solr.sh'].each do |shell|
    config.vm.provision :shell, path: "provisioning/shell/#{shell}"
  end
end
