require 'spec_helper'

describe MembersController do

  describe "access control" do

    describe "not signed in users" do
      it 'should require user to be signed in before create' do
        post :create
        response.should redirect_to(new_user_session_path)
      end

      it 'should require user to be signed in before delete' do
        delete :destroy, :id => "1"
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST 'create'" do

    describe "for signed in with privilege" do

      login_privileged

      before(:each) do
        @team = Factory(:team)
      end

      it 'should create a member' do
        lambda do
          xhr :post, :create, :member => {:team_id => @team}
        end.should change(Member, :count).by(1)
      end
    end
  end
  describe "DELETE 'destroy'" do

    describe "for signed in with privilege" do

      login_privileged

      before(:each) do
        @team = Factory.build(:team)
        @user.want_to_join!(@team)
        @member = @user.members.find_by_team_id(@team)
      end
      
      it 'should require privileged user to destroy' do
        lambda do
          xhr :delete, :destroy, :id => @member
        end.should change(Member, :count).by(-1)
      end
    end
  end

end
