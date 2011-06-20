require 'spec_helper'

describe Task do

  before(:each) do
    @task = Factory(:task)
    @project = Factory(:project, :name => "hihihi")
    @attributes = {
      :name => "task2",
      :description => "very long description",
      :priority => 1,
      :progress => 25.0,
      :start_date => 2.days.ago,
      :due => Date.today
    }
  end

  it 'should create a task for project' do
    @project.tasks.create!(@attributes)
  end

  context "project association" do
 
    before(:each) do
       @task = @project.tasks.create!(@attributes)
    end
    
    it 'should respond to project' do
      @task.should respond_to(:project)
    end

    it 'should have the right project' do
      @task.project_id.should == @project.id
      @task.project.should == @project
    end
  
  end

  context "validations" do
  
     it 'should have a name' do
       @task.name = ""
       @task.should_not be_valid
     end

     it 'should not have too long name' do
       long_name = "m" * 51
       @task.name = long_name
       @task.should_not be_valid
     end

     it 'should have a description' do
       @task.description = ""
       @task.should_not be_valid
     end

     it 'should have a start date' do
       @task.start_date = nil
       @task.should_not be_valid
     end

     it 'should have a due date' do
       @task.due = nil
       @task.should_not be_valid
     end

     it 'should have a priority' do
       @task.priority = nil
       @task.should_not be_valid
     end

     it 'role should have a priority between 1 and 6' do
       @task.priority = 7
       @task.should_not be_valid
     end

     it 'should have a progress' do
       @task.progress = nil
       @task.should_not be_valid
     end

     it 'should not have progress that exceed 100' do
       @task.progress = 101.0
       @task.should_not be_valid
     end

     it 'should not have progress with letter' do
       @task.progress = 'm' * 5
       @task.should_not be_valid
     end
  
  end
end
