# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

DEST = '~vagrant'
SRC = File.expand_path(File.join(File.dirname(__FILE__), 'shared/dotfiles'))
DOTFILES = Dir[File.join(SRC, '.??*')].delete_if{|f| File.extname(f) =~ /\.sw?/ }

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'trusty-server-cloudimg-amd64'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.network :private_network, ip: '192.168.33.100', virtualbox__intnet: true
  config.ssh.forward_agent = true

  config.vm.synced_folder './shared/vim', '/home/vagrant/.vim'
  config.vm.synced_folder './shared/bin', '/home/vagrant/bin'
  config.vm.synced_folder '~/Projects', '/home/vagrant/projects'

  config.vm.provider 'virtualbox' do |v|
    v.name = 'Ubuntu Server 14.04 (64-bit)'
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbook.yml'
    #ansible.verbose = 'vvv'
  end

  DOTFILES.each do |file|
    config.vm.provision :file do |f|
      f.source = file
      file = '.bash_profile' if File.basename(file) == '.profile'
      f.destination = File.join(DEST, File.basename(file))
    end
  end

  {'~/.ssh/id_rsa' => '600', '~/.ssh/id_rsa.pub' => '644'}.each do |file, mode|
    dest = File.join(DEST, '.ssh', File.basename(file))
    config.vm.provision :file, source: file, destination: dest
    config.vm.provision :shell, inline: "chmod #{mode} #{dest}"
  end
end
