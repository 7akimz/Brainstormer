require 'spec_helper'

describe Team do

  before(:each) do
    @user = Factory(:user)
    @attributes = { :name => "blue team", :role => 1, 
                    :email => "blue_team@example.com" }
  end
  context "Add new Team" do

    it 'should create a new team and associate it with user' do
      @user.teams.create!(@attributes) 
    end

    it 'should have a user associated with it' do
      team = Team.new(@attributes)
      team.users.each do |user|
        user.should_not be_nil
      end
    end

    it 'should require a name' do
      team = Factory.build(:team, :name => "")
      team.should_not be_valid
    end

    it 'should require a role' do
      team = Factory.build(:team, :role => "")
      team.should_not be_valid
    end

    it 'should require an email' do
      team = Factory.build(:team, :email => "")
      team.should_not be_valid
    end

    it 'should not accept invalid email' do
      email_addresses = %w[exak@rek,com hi_at_vi.org first.last@non.]
      email_addresses.each do |mail|
        invalid_email = Factory.build(:team, :email => mail)
        invalid_email.should_not be_valid
      end
    end

    it 'should accept valid emails' do
      email_addresses = %w[moh@moha.com Example@liv.com moh.ex@liv.jp]
      email_addresses.each do |mail|
        valid_email = Factory(:team, :email => mail)
        valid_email.should be_valid
      end
    end

    it 'should not accept too long names' do
      long_name = 'm' * 31
      team = Factory.build(:team, :name => long_name)
      team.should_not be_valid
    end
    it 'should not accept identical team names' do
      team = Team.create!(@attributes)
      identical_name_team = Team.new(@attributes)
      identical_name_team.should_not be_valid
    end
    it 'should not accept undefined roles' do
      team = Factory.build(:team, :role => 100)
      team.should_not be_valid
    end
  end

end
