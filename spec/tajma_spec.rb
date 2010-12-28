require_relative 'spec_helper'

describe Tajma do
  
  describe '#start' do
    before do
      FileUtils.rm db_path if File.exist?(db_path)
    end

    it "should create the database if it doesn't exists" do
      File.exist?(db_path).should == false
      Tajma.start(:task)
      File.exist?(db_path).should == true
    end

    it 'should insert a new line at the tasks table' do
      time = Time.now.to_i
      Tajma.start(:task)

      task = Tajma::Task.find_by_description(:task)

      task.description.should == :task.to_s
      task.start_time.should be_within(10).of(time)
    end

    after do
      FileUtils.rm File.expand_path(db_path) if File.exist?(db_path)
    end
  end
  
  describe '#stop' do
    
    before(:all) do
      setup_db!
    end
    
    it "should stop the given task printing it's summary" do
      output = StringIO.new
      
      t = Tajma::Task.create!(description: 'task1')
      Tajma.stop('task1', output)
      
      Tajma::Task.find_by_description('task1').stop_time.should be_within(10).of(Time.now.to_i)
      output.seek(0)
      output.read.chomp.should == t.reload.summary
    end
    
    it 'should print a message informing that a non-existent task could not be stopped' do
      output = StringIO.new
      
      Tajma.stop('efilnikufesin', output)
      output.seek(0)
      output.read.chomp.should == "No task with description efilnikufesin found."
    end
  end
end