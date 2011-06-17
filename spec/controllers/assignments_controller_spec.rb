require 'spec_helper'

describe AssignmentsController do
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
        session["team_id"] = @team.id
        @project = Factory(:project)
      end

      it 'should create a assignment' do
        lambda do
          xhr :post, :create, :assignment => {:project_id => @project}
        end.should change(Assignment, :count).by(1)
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for signed in user" do

      login_privileged

      before(:each) do
        @team = Factory(:team)
        project = Factory(:project)
        @team.assign_to!(project)
        session["team_id"] = @team.id
        @assignment = @team.assignments.find_by_project_id(project.id)
      end
      
      it 'should require privileged user to destroy' do
        lambda do
          xhr :delete, :destroy, :id => @assignment
        end.should change(Assignment, :count).by(-1)
      end
    end
  end

end
