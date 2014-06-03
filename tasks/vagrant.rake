namespace :vagrant do

  task :insecure_private_key, :key_file do |t, args|
    args.with_defaults(key_file: '~/.vagrant.d/insecure_private_key')
    sh "ssh-add #{args[:key_file]}"
  end

  desc 'Add local ssh key to the list of approved identities (default: "~/.ssh/id_rsa")'
  task 'ssh-add', :key_file do |t, args|
    args.with_defaults(key_file: '~/.ssh/id_rsa')
    sh "ssh-add -k #{args[:key_file]}"
  end

  desc 'Package the base Windows 7 virtual machine'
  task 'package-win7' do |t|
    sh 'vagrant package --base "Windows 7" --output ./boxes/windows-7-ultimate-32-jdantonio.box'
  end
end
