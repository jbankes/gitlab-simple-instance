# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   config.vm.box = "centos/7"

  # port fowarding
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # VM configuration
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
  end

  # ansible playbook provisioning
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = true
    ansible.playbook = "gitlab.yml"
    ansible.limit = "all"
  end
end
