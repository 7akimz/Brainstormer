require 'spec_helper'

describe Project::TasksController do

  before(:each) do
    @project = Factory(:project)
    @task = Factory(:task, :project => @project)
  end

  describe "access control" do

    it "should reject access to 'create'" do
      post :create, :project_id => 5
      response.should redirect_to(new_user_session_path)
    end

    it "should reject access to 'destroy'" do
      delete :destroy, :project_id => 1, :id => 1
      response.should redirect_to(new_user_session_path)
    end

    it "should reject access to 'show'" do
      get :show, :project_id => 1, :id => 1
      response.should redirect_to(new_user_session_path)
    end

    it "should reject access to 'index'" do
      get :index, :project_id => 1
      response.should redirect_to(new_user_session_path)
    end

    it 'should reject access to update' do
      put :update, :project_id => 1, :id => 1
      response.should redirect_to(new_user_session_path)
    end

    it 'should reject access to new' do
      get :new, :project_id => 1
      response.should redirect_to(new_user_session_path)
    end

    it 'should reject access to edit' do
      get :edit, :project_id => 1, :id => 1
      response.should redirect_to(new_user_session_path)
    end
  end
  
  describe "GET 'index'" do

    describe "when user signed in" do

      login_user

      it 'should respond to index action' do
        get :index, :project_id => @project
        response.should be_success
      end

      it 'should assign all tasks as @task' do
        tasks = @project.tasks
        get :index, :project_id => @project
        assigns(:tasks).should eq tasks
      end
    end
  end

  describe "GET 'show'" do

    describe "when user signed in" do
      login_user

      it 'should respond to show' do
        get :show, :project_id => @project, :id => @task
        response.should be_success
      end

      it 'should get the correct task' do
        @task = Factory(:task, :id => 5, :project => @project) 
        get :show, :project_id => @project, :id => @task
        assigns(:task).id.should == 5
      end
    end
  end

  describe "GET 'new'" do
    
    describe "when user signed in" do

      describe "for privileged users" do

        login_user

         it 'should respond to the new' do
          get :new, :project_id => @project
          response.should be_success
        end

        it 'should assigns new task as @task' do
          get :new, :project_id => @project
          assigns(:task).should_not be nil
        end

      end
            
    end
  end

  describe "GET 'edit'" do

    describe "when user signed in" do
      login_user

      it 'should respond to task' do
        get :edit, :project_id => @project, :id => @task
        response.should be_success
      end

      it 'should assigns the requested task as @task' do
        @task = Factory(:task, :id => '5', :project => @project) 
        get :edit, :project_id => @project, :id => '5'
        assigns(:task).id.should == 5
      end
    end
  end

  describe "POST 'create'" do

    describe "when user signed in" do

      login_user
      before(:each) do
        @task = Factory.build(:task)
      end
        
      it 'should not create a task with false params' do
        @task.name = ""
        post :create, :project_id => @project ,
                      :task => @task.attributes
        assigns(:task).save.should_not be_true
      end

      it 'should render the new action' do
        @task.description = ""
        post :create, :project_id => @project, 
                      :task => @task.attributes
        response.should render_template :new
      end

      it 'should assigns new task as @task' do
        post :create, :project_id => @project, 
                      :task => @task.attributes
        assigns(:task).name.should == @task.name
      end

      it 'should increase the database record by 1' do
        lambda do
          post :create, :project_id => @project, 
                        :task => @task.attributes
        end.should change(Task, :count).by(1)
      end

      it 'should redirect to show action' do
        post :create, :project_id => @project, 
                      :task => @task.attributes
        response.should redirect_to(project_task_path(
          assigns(:task)))
      end
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @attributes = {
        :name  =>"update",
        :description => "an example of a description",
        :address => "Egypt, nasr city",
        :priority => 3,
        :progress => 60.0,
        :start_date =>  1.week.ago,
        :due => Date.today
      }
    end

    describe "when user signed in" do

      login_user

      it 'should not update invalid attribute' do
        @attributes[:name] = ""
        put :update, :project_id => @project, :id => @task, 
                     :task => @attributes
        response.should render_template(:edit)
      end

      it 'should update attributes' do
        put :update, :project_id => @project, :id => @task, 
          :task => @attributes
        @task.reload
        @task.name.should == @attributes[:name]
        @task.description.should == @attributes[:description]
        @task.priority.should == @attributes[:priority]
      end

      it 'should redirect to show page' do
        put :update, :project_id => @project, :id => @task,
                     :task => @attributes
        response.should redirect_to(project_task_path(@task))
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    describe "when user signed in" do
      
      login_user

        it 'should delete user' do
          lambda do
            delete :destroy, :project_id => @project.id, :id => @task
          end.should change(Task, :count).by(-1)
        end

        it 'should redirect to tasks page' do
          delete :destroy, :project_id => @project, :id => @task
          response.should redirect_to project_tasks_path
        end
    end
  end

end
