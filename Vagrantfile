# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

UNIX_HOME = '/home/vagrant'
WIN7_HOME = 'C:/Users/vagrant'

SRC = File.expand_path(File.join(File.dirname(__FILE__), 'shared/dotfiles'))
DOTFILES = Dir[File.join(SRC, '.??*')].delete_if{|f| File.extname(f) =~ /\.sw?/ }

def windows_host?
  host_os = RbConfig::CONFIG['host_os']
  host_os =~ /mswin32/i || host_os =~ /mingw32/i
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.forward_agent = true unless windows_host?

  config.vm.define 'cfg', primary: true do |cfg|

    cfg.vm.box = 'trusty-server-cloudimg-amd64'
    cfg.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

    cfg.vm.synced_folder './shared/vim', "#{UNIX_HOME}/.vim"
    cfg.vm.synced_folder './shared/bin', "#{UNIX_HOME}/bin"
    cfg.vm.synced_folder '~/Projects', "#{UNIX_HOME}/projects"

    cfg.vm.provider 'virtualbox' do |v|
      v.name = 'Ubuntu Server 14.04 (64-bit)'
      v.memory = 2048
      v.cpus = 1
    end

    unless windows_host?
      cfg.vm.provision 'ansible' do |ansible|
        ansible.playbook = 'playbook.yml'
        #ansible.verbose = 'vvv'
      end
    end

    #DOTFILES.each do |file|
      #config.vm.provision :file do |f|
        #f.source = file
        #file = '.bash_profile' if File.basename(file) == '.profile'
        #f.destination = File.join(UNIX_HOME, File.basename(file))
      #end
    #end

    #{'~/.ssh/id_rsa' => '600', '~/.ssh/id_rsa.pub' => '644'}.each do |file, mode|
      #dest = File.join(UNIX_HOME, '.ssh', File.basename(file))
      #config.vm.provision :file, source: file, destination: dest
      #config.vm.provision :shell, inline: "chmod #{mode} #{dest}"
    #end
  end

  ### `vagrant package --base "Windows 7 Ultimate (32-bit)" --output ./boxes/windows-7-ultimate-32-jdantonio.box`
  config.vm.define 'win7' do |cfg|

    cfg.vm.box = 'windows-7-ultimate-32-jdantonio'
    cfg.vm.box_url = './boxes/windows-7-ultimate-32-jdantonio.box'

    cfg.vm.communicator = 'winrm'
    cfg.windows.set_work_network = true

    cfg.vm.network :forwarded_port, host: 5985, guest: 5985, id: 'winrm', auto: true
    cfg.vm.network :forwarded_port, host: 3389, guest: 3389, id: 'rdp', auto: true

    cfg.vm.provider :virtualbox do |vb|
      vb.gui = true
    end

    cfg.vm.provider 'virtualbox' do |v|
      v.name = 'Windows 7 Ultimate (32-bit)'
      v.memory = 4096
      v.cpus = 1
    end
  end

  config.vm.define 'centos' do |cfg|

    cfg.vm.box = 'centos-6_5-x86_64'
    cfg.vm.box_url = 'https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box'

    cfg.vm.provider 'virtualbox' do |v|
      v.name = 'CentOS 6.5'
      v.memory = 2048
      v.cpus = 1
    end
  end
end
