def config_centos_6_5(cfg)

  cfg.vm.box = 'centos-6_5-x86_64'
  cfg.vm.box_url = 'https://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140504.box'

  cfg.vm.provider 'virtualbox' do |v|
    v.name = 'CentOS 6.5'
    v.memory = 2048
    v.cpus = 1
  end
end
