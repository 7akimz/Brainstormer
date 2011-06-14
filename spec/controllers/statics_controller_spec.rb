require 'spec_helper'

describe StaticsController do
  render_views

  describe "without signed in user" do

    before(:each) do
      get :index
    end

    it 'should be successful' do
      response.should be_success
    end

  end

  describe "with signed in user" do
    login_user

    before(:each) do
      second_user = Factory(:user, :email => "someemail@example.com")
      second_user.follow!(@user)
      get 'index'
    end

    it 'should get index' do
      response.should be_success
    end
  end

end
