require 'active_record'
require 'tajma/configuration'
require 'tajma/task'

module Tajma
  extend self
  
  def start(name)
    Tajma::Configuration.configure!
    
    Tajma::Task.create!(description: name, start_time: Time.now.to_i)
  end
  
  def stop(name, out=$stdout)
    Tajma::Configuration.configure!
    
    task = Tajma::Task.stop(name)
    if task
      out.puts task.summary
    else
      out.puts "No task with description #{name} found."
    end
  end
end