require 'spec_helper'

describe Assignment do
  before(:each) do
    @team = Factory(:team)
    @project = Factory(:project)

    @assignment = @team.assignments.build(:project_id => @project.id)
  end

  it 'should create an assignment given valid attributes' do
    @assignment.save!.should be_true
  end

  context "validations" do

    it 'should have a team_id' do
      @assignment.team_id = nil
      @assignment.should_not be_valid
    end  

    it 'should have a project_id' do
      @assignment.project_id = nil
      @assignment.should_not be_valid
    end
  end
  
  context "join" do
  
   before(:each) do
     @assignment.save
   end

   it 'should have a team attribute' do
     @assignment.should respond_to(:team)
   end

   it 'should have the right team' do
     @assignment.team.should == @team
   end

   it 'should have a project attribute' do
     @assignment.should respond_to(:project)
   end

   it 'should have the right project' do
     @assignment.project.should == @project
   end
  
  end
end
