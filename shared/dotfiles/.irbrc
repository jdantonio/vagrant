require 'rubygems'
require 'pp'
#require 'irb/completion'
#IRB.conf[:AUTO_INDENT]=true

if defined?(Rails)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

def gemocide
  `gem list --no-versions`.split("\n").each do |gem|
    `gem list -d #{gem}`.gsub(/Installed at(.*):.*/).each do |dir|
      dir = dir.gsub(/Installed at(.*): /,'').gsub("\n", '')
      system "gem uninstall #{gem} -aIx -i #{dir}"
    end  
  end
end

#require 'irbtools'
#require 'irbtools/configure'
#Irbtools.add_package :more
#Irbtools.start
