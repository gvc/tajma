require 'tajma'
require 'fileutils'
require 'shoulda'

RSpec.configure do |config|
  config.mock_with :rspec
  
  config.include Shoulda::ActiveRecord::Matchers
end

def db_path
  File.expand_path('~/.tajma/tajma.sqlite3')
end

def setup_db!
  ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: db_path)
  ActiveRecord::Base.connection.create_table :tasks do |t|
    t.string :description
    t.integer :start_time
    t.integer :stop_time
  end unless ActiveRecord::Base.connection.tables.include? 'tasks'
end