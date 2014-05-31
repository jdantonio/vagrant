# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'trusty-server-cloudimg-amd64'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.network :private_network, ip: '192.168.33.100', virtualbox__intnet: true
  #config.vm.network :private_network, ip: '192.168.33.100'
  config.ssh.forward_agent = true

  config.vm.synced_folder '/Users/Jerry/Projects', '/home/vagrant/projects'
  config.vm.synced_folder '/Users/Jerry/.vim', '/home/vagrant/.vim'
  config.vm.synced_folder '/Users/Jerry/bin', '/home/vagrant/bin'

  config.vm.provider 'virtualbox' do |v|
    v.name = 'Ubuntu Server 14.04 (64-bit)'
    v.memory = 4096
    v.cpus = 2
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbook.yml'
    #ansible.verbose = 'vvv'
  end
end
