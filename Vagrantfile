# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant/util/platform'

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = '2'

# Load files in the support directory
Dir.glob('support/**/*.rb').each {|file| load file }

CPUS = processor_count # from support

# Vagrant configuration
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.forward_agent = true unless Vagrant::Util::Platform.windows?

  # Ubuntu for development
  config.vm.define 'ubuntu', primary: true do |cfg|

    cfg.vm.box = 'ubuntu/trusty64'

    cfg.vm.provision :shell, :privileged => false, :path => 'scripts/common.sh'
    cfg.vm.provision :shell, :privileged => false, :path => 'scripts/ruby-rvm.sh', :args => ['1.9.3','2.0','2.1','2.2']
    cfg.vm.provision :shell, :path => 'scripts/jdk.sh'
    cfg.vm.provision :shell, :path => 'scripts/javascript.sh'
    cfg.vm.provision :shell, :path => 'scripts/phantomjs.sh'

    cfg.vm.provider 'virtualbox' do |v|
      v.name = 'Ubuntu'
      v.memory = 4096
      v.cpus = CPUS
    end

    # from support
    copy_ssh_keys(cfg)
    setup_dotfiles(cfg)
  end
end
