#NOTE: Based on tasks I created at work. I may not need them at home.
namespace :vagrant do

  SSH_ADD = 'ssh-add -l'
  SUDO = "sudo su"
  GO_HOME = "cd ~"

  task :insecure_private_key, :key_file do |t, args|
    args.with_defaults(key_file: '~/.vagrant.d/insecure_private_key')
    sh "ssh-add #{args[:key_file]}"
  end

  desc 'Add local ssh key to the list of approved identities (default: "~/.ssh/id_rsa")'
  task 'ssh-add', :key_file do |t, args|
    args.with_defaults(key_file: '~/.ssh/id_rsa')
    sh "ssh-add -k #{args[:key_file]}"
  end

  desc 'Start a virtual machine'
  task :up => 'ssh-add' do
    sh "vagrant up"
  end

  desc 'Provision the virtual machine using the Ansible script'
  task :provision => [:up] do
    sh "#{SSH_ADD} && vagrant provision"
  end

  desc 'Secure shell into a running virtual machine'
  task :ssh => 'ssh-add' do
    sh "vagrant ssh -- -A"
  end

  desc 'Shut down a running virtual machine'
  task :halt do
    sh "vagrant halt"
  end
end
