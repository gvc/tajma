require 'fileutils'

module Tajma
  module Configuration
    extend self
  
    def configure!
      if set_up?
        connect
      else
        set_up!
        connect
        create_database
      end
    end
  
  private
    def set_up?
      File.exists?(db_path)
    end
  
    def set_up!
      FileUtils.mkdir(File.dirname(db_path)) unless Dir.exists?(File.dirname(db_path))
      FileUtils.touch(db_path)
    end
    
    def connect
      ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: db_path)
    end
    
    def create_database
      ActiveRecord::Base.connection.create_table :tasks do |t|
        t.string :description
        t.integer :start_time
        t.integer :stop_time
      end
    end
  
    def db_path
      File.expand_path("~/.tajma/tajma.sqlite3")
    end
  end
end