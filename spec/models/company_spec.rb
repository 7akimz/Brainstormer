require 'spec_helper'

describe Company do

  before(:each) do
    @company = Factory(:company)
    @team = Factory(:team)
    @attributes = {
      :name => "valid",
      :email => "valid@company.com",
      :telephone => "224015819",
      :country => 1,
      :address => "my company address",
      :capital => 10000
    }
  end
  
  it 'should create new company give valid attributes' do
    Company.create!(@attributes)
  end

  it 'should create a company associated with a team' do
    @team.work_in!(@company)
  end

  context "team association" do
  
     before(:each) do
       @team.companies.create!(@attributes)
     end

     it 'should respond to team' do
       @company.should respond_to(:teams)
     end

  end

  context "validations" do
  
    it 'should require a name' do
      @company.name = ""
      @company.should_not be_valid
    end

    it 'should have a unique name' do
      company1 = Factory(:company, :name => "company")
      company = Factory.build(:company, :name => "company")
      company.should_not be_valid
    end

    it 'should not have a too long name' do
      long_name = "m" * 51
      @company.name = long_name
      @company.should_not be_valid
    end

    it 'should require an email' do
      @company.email = ""
      @company.should_not be_valid
    end

    it 'should not accept invalid emails' do
      email_addresses = %w[lola@com no_at_company.com company@rik.]
      email_addresses.each do |address|
        @company.email = address
        @company.should_not be_valid
      end
    end

    it 'should require an address' do
      @company.address = ""
      @company.should_not be_valid
    end

    it 'should require a telephone' do
      @company.telephone = nil
      @company.should_not be_valid
    end

    it 'should accept numbers only for telephone' do
      @company.telephone = "a" * 8
      @company.should_not be_valid
    end

    it 'should require a capital' do
      @company.capital = nil
      @company.should_not be_valid
    end

    it 'should not accept invalid attributes for capital' do
      @company.capital = "c" * 5
      @company.should_not be_valid
    end

  end
end
