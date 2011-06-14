require 'spec_helper'

describe Post do
  before(:each) do
    @user = Factory(:user)
    @attributes = { :content => "an example content" }
  end
  context "Adding a Post" do
     it 'should create a post given valid attributes' do
       @user.posts.create!(@attributes)
     end
  end

  context "user associations" do
    before(:each) do
      @post = @user.posts.create(@attributes)
    end

    it 'should have a user' do
      @post.should respond_to(:user)
    end

    it 'shoud have the right associated user' do
      @post.user_id.should == @user.id
      @post.user.should == @user
    end
  end

  context "Validations" do
  
    it 'should have a user' do
      Post.new(@attributes).should_not be_valid
    end

    it 'should have a content' do
      @user.posts.build(:content => "  ").should_not be_valid
    end
  
  end

  context "from_users_followed_by" do

    before(:each) do
      @first_followed = Factory(:user, 
                                :email => 
                                "first_followed@example.com",
                                :username => "first_followed")
      @second_followed = Factory(:user, 
                                 :email => 
                                 "second_followed@example.com",
                                 :username => "second_followed")
      @user_post = @user.posts.create!(:content => "new post")
      @first_post = @first_followed.posts.create(
        :content => "first post")
      @second_post = @second_followed.posts.create(
        :content => "second post")
      @user.follow!(@first_followed)
    end

    it 'should have a from_users_followed_by class method' do
      Post.should respond_to(:from_users_followed_by)
    end

    it 'should include the followed users posts' do
      Post.from_users_followed_by(@user).should include(
        @first_post)
    end

    it 'should include the user post' do
      Post.from_users_followed_by(@user).should include(@user_post)
    end

    it "should not include an unfollowed user's post" do
      Post.from_users_followed_by(@user).should_not include(
        @second_followed)
    end
  end

end
