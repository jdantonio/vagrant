def config_ubuntu_development_server(cfg)

  cfg.vm.box = 'trusty-server-cloudimg-amd64'
  cfg.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  cfg.vm.provider 'virtualbox' do |v|
    v.name = 'Ubuntu 14.04 (Ruby Development)'
    v.memory = 2048
    v.cpus = 1
  end

  unless windows_host?
    cfg.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'ubuntu-ruby-server.yml'
      #ansible.verbose = 'vvv'
    end
  end

  setup_dotfiles(cfg)
end
