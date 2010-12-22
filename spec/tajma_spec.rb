require_relative 'spec_helper'

describe Tajma do
  
  before do
    @path = File.expand_path('~/.tajma')
    FileUtils.rm @path if File.exist?(@path)
  end
  
  it "#start should create a file called .tajma if it doesn't exists" do
    File.exist?(@path).should == false
    
    Tajma.start(:task)
    
    File.exist?(@path).should == true
  end
  
  it '#start should append a line at the end of the file with the name of the giving task' do
    time = Time.now.to_i
    Tajma.start(:task)
    
    File.open(@path) do |file|
      entry = file.readline.chomp.split(':')
      
      entry.first.should == :task.to_s
      entry.last.to_i.should be_within(5).of(time)
    end
  end
  
  after(:all) do
    FileUtils.rm File.expand_path('~/.tajma')
  end
end