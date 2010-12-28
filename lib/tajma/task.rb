module Tajma
  class Task < ActiveRecord::Base
    
    validates_presence_of :description
    validates_length_of :description, minimum: 4
    
    def start_time
      self[:start_time] || Time.now.to_i
    end
    
    def summary
      summary = "Task #{self.description} completed in "
      time = time_spent
      
      hours = time / 3600
      time = time % 3600
      
      minutes = time / 60
      seconds = time % 60
      
      append_and = false
      
      if !hours.zero?
        summary << "#{hours} hours"
        append_and = true
      end
      
      if !minutes.zero?
        summary << ' and ' if append_and
        summary << "#{minutes} minutes"
        append_and = true
      end
      
      if !seconds.zero?
        summary << ' and ' if append_and
        summary << "#{seconds} seconds"
      end
      
      summary
    end
    
    def time_spent
      return unless self.stop_time
      self.stop_time - self.start_time
    end
    
    def self.stop(description)
      task = self.find_by_description!(description)
      task.stop_time = Time.now.to_i
      task.save
      task
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end