GUEST_HOME = '/home/vagrant'

# https://github.com/grosser/parallel/blob/master/lib/parallel.rb
# http://serverfault.com/questions/112711/how-can-i-get-cpu-count-and-total-ram-from-the-os-x-command-line
def processor_count(default = 2)
  count = 0
  os_name = RbConfig::CONFIG["target_os"]

  if os_name =~ /mingw|mswin/
    require 'win32ole'
    result = WIN32OLE.connect("winmgmts://").ExecQuery(
      "select NumberOfLogicalProcessors from Win32_Processor")
    count result.to_enum.collect(&:NumberOfLogicalProcessors).reduce(:+)
  elsif os_name =~ /^darwin/
    count = `sysctl hw.ncpu`.chomp.gsub(/^\D+/, '').to_i
  else
    count = `sysctl hw.ncpu`.chomp.gsub(/^\D+/, '').to_i
  end

  count > 0 ? count : default
rescue
  default
end

# https://github.com/erikhuda/thor/blob/master/lib/thor/util.rb
def user_home
  if ENV['HOME']
    ENV['HOME']
  elsif ENV['USERPROFILE']
    ENV['USERPROFILE']
  elsif ENV['HOMEDRIVE'] && ENV['HOMEPATH']
    File.join(ENV['HOMEDRIVE'], ENV['HOMEPATH'])
  elsif ENV['APPDATA']
    ENV['APPDATA']
  else
    begin
      File.expand_path('~')
    rescue
      if File::ALT_SEPARATOR
        'C:/'
      else
        '/'
      end
    end
  end
end

def copy_ssh_keys(config, home = GUEST_HOME)
  guest_ssh_dir = File.expand_path(File.join(user_home, '.ssh'))
  if File.directory?(guest_ssh_dir)
    {"#{guest_ssh_dir}/id_rsa" => "600", "#{guest_ssh_dir}/id_rsa.pub" => '644'}.each do |file, mode|
      dest = File.join(home, '.ssh', File.basename(file))
      config.vm.provision :file, source: file, destination: dest
      config.vm.provision :shell, inline: "chmod #{mode} #{dest}"
    end
  end
end

def sync_host_home_to_guest(config)
  config.vm.synced_folder user_home, "#{GUEST_HOME}/my-home"
end
