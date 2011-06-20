require 'spec_helper'

describe Worker do

  before(:each) do
    @team = Factory(:team)
    @company = Factory(:company)

    @worker = @team.workers.build(:company_id => @company.id)
  end

  context "validations" do
  
    it 'should have a team id' do
      @worker.team_id = nil
      @worker.should_not be_valid
    end  

    it 'should have a company id' do
      @worker.company_id = nil
      @worker.should_not be_valid
    end
  
  end

  context "work in" do
  
    before(:each) do
      @worker.save
    end

    it 'should have a team attribute' do
      @worker.should respond_to(:team)
    end

    it 'should have the right team' do
      @worker.team.should == @team
    end
    
    it 'should have a company attribute' do
      @worker.should respond_to(:company)
    end

    it 'should have the right company' do
      @worker.company.should == @company
    end
  
  end
end
