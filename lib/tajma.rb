module Tajma
  extend self
  
  def start(name)
    File.open(File.expand_path('~/.tajma'), 'a+') do |file|
      file.pos = 0
      file.puts "#{name.to_s}:#{Time.now.to_i}"
    end
  end
end
