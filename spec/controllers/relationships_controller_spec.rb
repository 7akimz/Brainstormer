require 'spec_helper'

describe RelationshipsController do

  describe "access control" do

    it 'should require signed in user for create' do
      post :create
      response.should redirect_to(new_user_session_path)
    end

    it 'should require signed in user for destroy' do
      delete :destroy, :id => "1"
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "POST 'create'" do

    login_user

    before(:each) do
      @followed = Factory(:user, :email => "followed@user.com",
                          :username => "followed")
    end

    it 'should create a relationship' do
      lambda do
        xhr :post, :create, :relationship => { :followed_id =>
          @followed }
        response.should be_success
      end.should change(Relationship, :count).by(1)
    end
  end

  describe "DELETE 'destroy'" do

    login_user

    before(:each) do
      @followed = Factory(:user, :email => "followed@user.com",
                          :username => "followed")
      @user.follow!(@followed)
      @relationship = @user.relationships.find_by_followed_id(
        @followed)
    end

    it 'should destroy relationship' do
      lambda do
        xhr :delete, :destroy, :id => @relationship
        response.should be_success
      end.should change(Relationship, :count).by(-1)
    end
  end

end
