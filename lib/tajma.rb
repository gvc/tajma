require 'active_record'
require 'tajma/configuration'
require 'tajma/task'

module Tajma
  extend self
  
  def start(name)
    set_up!
    
    Tajma::Task.create!(description: name)
  end
  
  def stop(name, out=$stdout)
    set_up!
    
    task = Tajma::Task.stop(name)
    if task
      out.puts task.summary
    else
      out.puts "No task with description #{name} found."
    end
  end
  
private
  def set_up!
    unless Tajma::Configuration.set_up?
      Tajma::Configuration.set_up!
    end
  end
end