require 'spec_helper'

describe UsersController do
  render_views
  
  login_user
  
  describe "GET 'index'" do

    it "should respond to index action" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do

    #before(:each) do
      #@user = Factory(:user)
    #end
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

end
