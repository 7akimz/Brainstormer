require 'spec_helper'

describe Project do
  
  before(:each) do
    @team = Factory(:team)
    @project = Factory(:project)
    @attributes = {
      :name  =>"test",
      :description => "an example of a description",
      :address => "Egypt, nasr city",
      :budget => 1000.0,
      :side_notes =>"a side note example",
      :start_date =>  1.week.ago,
      :due => Time.now
    }
  end

  context "Add new Project" do
    
    it 'should create a new project and associate it with a team' do
      @team.projects.create!(@attributes)
    end

    it 'should have a team' do
      @project.should respond_to(:teams)
    end

    context "validations" do
    
      it 'should require a name' do
        @project.name = ""
        @project.should_not be_valid
      end

      it 'should have a unique name' do
        project = Factory(:project, :name => "the project")
        new_project = Factory.build(:project, :name => "the project")
        new_project.should_not be_valid
      end

      it 'should require a description ' do
        @project.description = ""
        @project.should_not be_valid
      end

      it 'should require an address' do
        @project.address = ""
        @project.should_not be_valid
      end

      it 'should require budget' do
        @project.budget = nil
        @project.should_not be_valid
      end

      it 'should require a start_date' do
        @project.start_date = nil
        @project.should_not be_valid
      end

      it 'should require a due date' do
        @project.due = nil
        @project.should_not be_valid
      end
      
      it 'should not accept too long names' do
        too_long_name = "a" * 61
        @project.name = too_long_name
        @project.should_not be_valid
      end

      it 'should not accept too short names' do
        too_short_name = "a" * 2
        @project.name = too_short_name
        @project.should_not be_valid
      end
    end

  end

end
