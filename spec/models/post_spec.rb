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
end
