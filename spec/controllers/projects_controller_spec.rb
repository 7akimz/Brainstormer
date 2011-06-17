require 'spec_helper'

describe ProjectsController do
  before(:each) do
    @project = Factory(:project)

    @attributes = {
      :name  =>"test",
      :description => "an example of a description",
      :address => "Egypt, nasr city",
      :budget => 1000.0,
      :side_notes =>"a side note example",
      :start_date =>  1.week.ago,
      :due => Date.today
    }

  end

  describe "GET 'index'" do

    describe "when user not signed in" do
      it 'should deny access to index' do
        get :index
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to show' do
        get :index
        response.should_not be_success
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to index action' do
        get :index
        response.should be_success
      end

      it 'should assign all projects as @project' do
        projects = Project.all
        get :index
        assigns(:projects).should eq projects
      end
    end
  end

  describe "GET 'show'" do

    describe "when user not signed in" do

      it 'should should deny access' do
        get :show, :id => 1
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to show' do
        get :show, :id => 1
        response.should_not be_success
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to show' do
        get :show, :id => @project
        response.should be_success
      end

      it 'should get the correct project' do
        project = Factory(:project, :name => "show", :id => "5")
        get :show, :id => 5
        assigns(:project).id.should == 5
      end
    end
  end

  describe "GET 'new'" do
    
    describe "when user not signed in" do
      
      it 'should deny access' do
        get :new
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to new' do
        get :new
        response.should_not be_success
      end
    end

    describe "when user signed in" do

      describe "for non privileged users" do
        login_user

        it 'should not respond to the new' do
          get :new
          response.should_not be_success
        end

        it 'should not assigns new project as @project' do
          get :new
          assigns(:project).should be nil
        end
      end

      describe "for privileged users" do

        login_privileged

         it 'should respond to the new' do
          get :new
          response.should be_success
        end

        it 'should assigns new project as @project' do
          get :new
          assigns(:project).should_not be nil
        end

      end
            
    end
  end

  describe "GET 'edit'" do

    describe "when user not signed in" do

      it 'should deny access' do
        get :edit, :id => @project
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to edit' do
        get :edit, :id => @project
        response.should_not be_success
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to project' do
        get :edit, :id => @project
        response.should be_success
      end

      it 'should assigns the requested project as @project' do
        project = Factory(:project, :id => '5', :name => "edit") 
        get :edit, :id => '5'
        assigns(:project).id.should == 5
      end
    end
  end

  describe "POST 'create'" do

    describe "when user not signed in" do

      it 'should deny access' do
        post :create, :project => @project.attributes
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do

      describe "for non privileged user" do

        login_user

        it 'should not respond to create' do
          post :create, :project => @project.attributes
          response.should redirect_to(root_path)
        end
      end

      describe "for privileged user" do

        login_privileged

        it 'should not create a project with false params' do
          @project.name = ""
          post :create, :project => @project.attributes
          assigns(:project).save.should_not be_true
        end

        it 'should render the new action' do
          @project.description = ""
          post :create, :project => @project.attributes
          response.should render_template :new
        end

        it 'should assigns new project as @project' do
          post :create, :project => @project.attributes
          assigns(:project).name.should == @project.name
        end

        it 'should increase the database record by 1' do
          lambda do
            post :create, :project => @attributes
          end.should change(Project, :count).by(1)
        end

        it 'should redirect to show action' do
          post :create, :project => @attributes
          response.should redirect_to(project_path(
            assigns(:project).id))
        end
      end
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @attributes = {
        :name  =>"test",
        :description => "an example of a description",
        :address => "nasr city",
        :budget => 2000.0,
        :side_notes =>"a side note example",
        :start_date =>  1.week.ago,
        :due => Date.today
      }

    end

    describe "when user not signed in" do

      it 'should deny access' do
        put :update, :id => @project, :project => @attributes
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to update' do
        put :update, :id => @project, :project => @attributes
        response.should_not be_success
      end
    end

    describe "when user signed in" do

      login_user

      it 'should not update invalid attribute' do
        @attributes[:name] = ""
        put :update, :id => @project, :project => @attributes
        response.should render_template(:edit)
      end

      it 'should update attributes' do
        put :update, :id => @project, :project => @attributes
        @project.reload
        @project.name.should == @attributes[:name]
        @project.description.should == @attributes[:description]
        @project.budget.should == @attributes[:budget]
        @project.address.should == @attributes[:address]
      end

      it 'should redirect to show page' do
        put :update, :id => @project, :project => @attributes
        response.should redirect_to(project_path(@project))
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    describe "when no signed in user" do

      it 'should redirect to sign in page' do
        delete :destroy, :id => '1'
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to delete' do
        delete :destroy, :id => '1'
        response.should_not be_success
      end
    end

    describe "when user signed in" do
      
      describe "has no privilege"do
        
        login_user

        it 'should not delete project' do
          lambda do
            delete :destroy, :id => @project
          end.should_not change(Project, :count)
        end

        it 'should redirect to home page' do
          delete :destroy, :id => @project
          response.should redirect_to root_path
        end
      end

      describe "has privilege" do

        login_privileged

        it 'should delete user' do
          lambda do
            delete :destroy, :id => @project
          end.should change(Project, :count).by(-1)
        end

        it 'should redirect to projects page' do
          delete :destroy, :id => @project
          response.should redirect_to projects_path
        end
      end
    end
  end

end
