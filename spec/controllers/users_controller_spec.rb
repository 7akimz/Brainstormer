require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'index'" do
    
    describe "while user not signed in" do
      it 'should deny access to index action' do
        get :index
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "while user signed in" do
      login_user

      it "should respond to index action" do
        get :index
        response.should be_success
      end
    end

  end

  describe "GET 'show'" do
    login_user

    it "should respond to show action" do
      get :show, :id => @user
      response.should be_success
    end

    it "assigns the requested user as @user" do
      get :show, :id => @user
      assigns(:user).id.should == @user.id
    end

    it "should show user's post" do
      get :show, :id => @user
      @user.posts.each do |post|
        response.should have_selector("span.content", 
                                      :content => post.content)
      end
    end
  end
  
  describe "follow colleage page" do

    describe "while user not signed in" do

      it "should deny access to 'following'" do
        get :following, :id => "1"
        response.should redirect_to(new_user_session_path)
      end

      it 'should deny access to follower' do
        get :followers, :id => "1"
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "while user signed in" do
     login_user

     before(:each) do
       @second_user = Factory(:user, :email => "second@user.com",
                              :username => "second")
       @user.follow!(@second_user)
     end

     it 'should show user following' do
       get :following, :id => @user
       response.should be_success
     end

     it 'should show user followers' do
       get :followers, :id => @second_user
       response.should be_success
     end
    end

  end
end
