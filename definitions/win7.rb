def config_windows_7_ultimate(cfg)

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
