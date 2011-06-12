require 'spec_helper'

describe User do
  before(:each) do
    @user = {
      :name => "mohamed",
      :username => "mohamed",
      :email => "mohamed@test.com",
      :password => "mmmmmm",
      :address => "naser city",
      :country => 1,
      :role => 2,
      :mobile_number => "0111351995",
      :spoken_language => 1
    }
  end
  context "Adding a User" do
    it 'should create new user given valid inputs' do
      user = User.create!(@user)
      user.should be_valid
    end

    it 'should require an email' do
      user = Factory.build(:user, :email => "")
      #user = User.new(@user.merge(:email => ""))
      user.should_not be_valid
    end

    it 'should reject invalid email addresses' do
      emails = %w[user@live,com user_at_live.org example.user@foo. 
                  example]
      emails.each do |email_address|
        wrong_email = Factory.build(:user, :email => email_address)
        wrong_email.should_not be_valid
      end
    end

    it 'should require a username' do
      user = Factory.build(:user, :username => "")
      user.should_not be_valid
    end

    it 'should have unique username' do
      Factory(:user, :username => "looool")
      user = Factory.build(:user, :username => "looool") 
      user.should_not be_valid
    end

    it 'should reject username with administrative names' do
      usernames = %w[admin webmaster superuser]
      usernames.each do |username|
        invalid_username = Factory.build(:user, :username =>
                                         username)
        invalid_username.should_not be_valid
      end
    end

    it 'should require a pre-defined role' do
      user = Factory.build(:user, :role => 20)
      user.should_not be_valid
    end

    it 'should require a pre-defined country' do
      user = Factory.build(:user, :country => 70) 
      user.should_not be_valid
    end

    it 'should require a pre-defined language' do
      user = Factory.build(:user, :spoken_language => 70)
      user.should_not be_valid
    end

    it 'should reject too long username' do
      long_name = "m" * 31
      user = Factory.build(:user, :username => long_name)
      user.should_not be_valid
    end

    it 'should reject short username' do
      short_name = "m" * 2
      user = Factory.build(:user, :username => short_name)
      user.should_not be_valid
    end

    it 'should required mobile_numbers to be numeric' do
      number = 'm' * 10
      user = Factory.build(:user, :mobile_number => number)
      user.should_not be_valid
    end

    it 'should not allow short mobile nubmers' do
      number = 000000000
      user = Factory.build(:user, :mobile_number => number)
      user.should_not be_valid
    end

    it 'should require a name' do
      user = Factory.build(:user, :name => '')
      user.should_not be_valid 
    end

    it 'should reject too long names' do
      long_name = "m" * 51
      user = Factory.build(:user, :name => long_name)
      user.should_not be_valid
    end

    it 'should require a password' do
      user = Factory.build(:user, :password => "")
      user.should_not be_valid
    end

    it 'should require password and its confirmation to match' do
      user = Factory.build(:user, :password => "nonono", 
                           :password_confirmation => "example")
      user.should_not be_valid
    end

    it 'should reject too short passwords' do
      short_pass = "hihii"
      user = Factory.build(:user, :password => short_pass, 
                           :password_confirmation => short_pass)
      user.should_not be_valid
    end
  end

  context "admin" do
    before(:each) do
      @admin = Factory(:user)
    end

    it 'should respond to admin' do
      @admin.should respond_to(:admin)
    end

    it 'should not be admin by default' do
      @admin.should_not be_admin
    end

    it 'should be toggled to admin' do
      @admin.toggle!(:admin)
      @admin.should be_admin
    end
  end

  context "Post associations" do

    before(:each) do
      @user = Factory(:user)
      @first_post = Factory(:post, :user => @user,
                            :created_at => 2.day.ago)
      @second_post = Factory(:post, :user => @user, 
                             :created_at => 1.day.ago)
    end
  
    it 'should have a post attribute' do
      @user.should respond_to(:posts)
    end
    
    it 'should have posts in order' do
      @user.posts.should == [@second_post, @first_post]
    end

    it 'should destroy associated post' do
      @user.destroy
      [@second_post, @first_post].each do |post|
        Post.find_by_id(post.id).should be_nil
      end
    end

    context "feed" do
    
      it 'should have a feed' do
        @user.should respond_to(:feed)
      end

      it 'should include the posts' do
        @user.feed.include?(@first_post).should be_true
        @user.feed.include?(@second_post).should be_true
      end

      it 'should not include wrong posts' do
        post = Factory(:post, 
                       :user => Factory(:user, :email => 
                                          "figure@fig.com",
                                        :username => 
                                          "newname"))
        @user.feed.include?(post).should be_false

      end
    
    end
  end
end
