SRC = File.expand_path(File.join(File.dirname(__FILE__), 'shared/dotfiles'))
DOTFILES = Dir[File.join(SRC, '.??*')].delete_if{|f| File.extname(f) =~ /\.sw?/ }

def setup_dotfiles(cfg)

  cfg.vm.synced_folder './shared/vim', "#{UNIX_HOME}/.vim"
  cfg.vm.synced_folder './shared/bin', "#{UNIX_HOME}/bin"
  cfg.vm.synced_folder '~/Projects', "#{UNIX_HOME}/projects"

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
