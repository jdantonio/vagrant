def config_ubuntu_development_server(cfg)

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

  DOTFILES.each do |file|
    cfg.vm.provision :file do |f|
      f.source = file
      file = '.bash_profile' if File.basename(file) == '.profile'
      f.destination = File.join(UNIX_HOME, File.basename(file))
    end
  end

  {'~/.ssh/id_rsa' => '600', '~/.ssh/id_rsa.pub' => '644'}.each do |file, mode|
    dest = File.join(UNIX_HOME, '.ssh', File.basename(file))
    cfg.vm.provision :file, source: file, destination: dest
    cfg.vm.provision :shell, inline: "chmod #{mode} #{dest}"
  end
end
