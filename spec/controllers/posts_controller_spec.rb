require 'spec_helper'

describe PostsController do
  render_views

  describe "access control" do

    it "should reject access to 'create'" do
      post :create
      response.should redirect_to(new_user_session_path)
    end

    it "should reject access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "POST 'create'" do
    login_user

    describe "invalid request" do

      before(:each) do
        @attributes = { :content => "" }
      end

      it 'should not create a post' do
        lambda do
          post :create, :post => @attributes
        end.should_not change(Post, :count)
      end

      it 'should render the user home page' do
        post :create, :post => @attributes
        response.should render_template('statics/index')
      end
    end

    describe "valid request" do
      before(:each) do
        @attributes = { :content => "an example post" }
      end

      it 'should create a new post' do
        lambda do
          post :create, :post => @attributes
        end.should change(Post, :count).by(1)
      end

      it 'should redirect to user home page' do
        post :create, :post => @attributes
        response.should redirect_to(root_path)
      end
    end
  end

  describe "Delete 'destroy'" do
    login_user
    before(:each) do
      another_user = Factory(:user, :email => "another@user.com", 												 :username => "another")
      @post = Factory(:post, :user => another_user)
    end

    it "should deny access" do
      delete :destroy, :id => @post
      response.should redirect_to(root_path)
    end

   describe " for authorized user" do
			
     before(:each) do
       @post = Factory(:post, :user => @user)
     end			

     it "should destroy the post" do
       lambda do
	 delete :destroy, :id => @post
       end.should change(Post, :count).by(-1)
      end
    end

  end
end

