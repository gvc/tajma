require_relative '../spec_helper'

describe Tajma::Task do
  
  before(:all) do
    setup_db!
  end
  
  it { should have_db_column(:description) }
  it { should have_db_column(:start_time) }
  it { should have_db_column(:stop_time) }
  
  it { should validate_presence_of(:description) }
  it { should ensure_length_of(:description).is_at_least(4) }
  
  it 'should have the start_time defaulting to now' do
    Tajma::Task.new.start_time.should be_within(10).of(Time.now.to_i)
  end
  
  describe '.time_spent' do
    it 'should return the time spent doing the task in seconds' do
      now = Time.now.to_i

      task = Tajma::Task.new
      task.start_time = now - 50
      task.stop_time = now
      
      task.time_spent.should == 50
      
      task.stop_time = now + 30
      task.time_spent.should == 80
    end
    
    it "should return nil if the task doesn't have a stop time" do
      Tajma::Task.new.time_spent.should be_nil
    end
  end
  
  describe '.summary' do 
    context 'should return a message displaying how many' do
      it 'seconds were spent in the task if the time spent is less than a minute' do
        task = Tajma::Task.new(description: 'task1')
        task.stub(time_spent: 50)
        task.summary.should == "Task #{task.description} completed in 50 seconds"
      end

      it 'minutes were spent in the task if the time spent is more than a minute and less than an hour' do
        task = Tajma::Task.new(description: 'task1')
        task.stub(time_spent: 357)
        task.summary.should == "Task #{task.description} completed in 5 minutes and 57 seconds"
      end

      it 'hours were spent in the task if the time spent is more than an hour' do
        task = Tajma::Task.new(description: 'task1')
        task.stub(time_spent: 3697)
        task.summary.should == "Task #{task.description} completed in 1 hours and 1 minutes and 37 seconds"
      end
    end    
  end
  
  describe '#stop' do
    before do
      Tajma::Task.create(description: 'develop')
    end
    
    it 'should stop a task and return true if the task exists' do
      Tajma::Task.stop('develop').should be_true
      Tajma::Task.find_by_description('develop').stop_time.should be_within(10).of(Time.now.to_i)
    end
    
    it "should return false it the task doesn't exist'" do
      Tajma::Task.stop('procrastinating').should be_false
    end
  end
end