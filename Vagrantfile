# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

UNIX_HOME = '/home/vagrant'
WIN7_HOME = 'C:/Users/vagrant'

SRC = File.expand_path(File.join(File.dirname(__FILE__), 'shared/dotfiles'))
DOTFILES = Dir[File.join(SRC, '.??*')].delete_if{|f| File.extname(f) =~ /\.sw?/ }

# Load all VM definitions
$:.push File.join(File.dirname(__FILE__), 'definitions')
Dir.glob('definitions/**/*.rb').each do |file|
  load file
end

def windows_host?
  host_os = RbConfig::CONFIG['host_os']
  host_os =~ /mswin32/i || host_os =~ /mingw32/i
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.forward_agent = true unless windows_host?

  config.vm.define 'ubuntu', primary: true do |cfg|
    config_ubuntu_development_server(cfg)
  end

  ### `vagrant package --base "Windows 7 Ultimate (32-bit)" --output ./boxes/windows-7-ultimate-32-jdantonio.box`
  config.vm.define 'win7' do |cfg|
    config_windows_7_ultimate(cfg)
  end

  config.vm.define 'centos' do |cfg|
    config_centos_6_5(cfg)
  end
end
