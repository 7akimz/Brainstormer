require 'spec_helper'

describe TeamsController do

  describe "GET 'index'" do

    describe "when user not signed in" do
      it 'should deny access to index' do
        get :index
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to index action' do
        get :index
        response.should be_success
      end

      it "should assigns all teams as @teams" do
        teams = Team.all
        get :index
        assigns(:teams).should eq teams
      end
    end

  end

  describe "GET 'show'" do

    before(:each) do
      @team = Factory(:team, :email => "showteam@team.com")
    end

    describe "when user not signed in" do
      it 'should deny access' do
        get :show, :id => @team
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to new show' do
        get :show, :id => @team
        response.should be_success
      end

      it 'should assigns the requested team as @team' do
        team = Factory(:team, :id => "10")
        get :show, :id => "10"
        assigns(:team).id.should == 10
      end
    end

  end

  describe "GET 'new'" do
    
    describe "when user not signed in" do

      it 'should deny access' do
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do
      login_user 
        
      it 'should respond to new action' do
        get :new
        response.should be_success
      end

      it 'should assigns a new team as @team' do
        get :new
        assigns(:team).should_not be nil
      end
    end

  end

  describe "GET 'edit'" do
    before(:each) do
      @team = Factory(:team)
    end

    describe "when user not signed in" do
      it 'should deny access' do
        get :edit, :id => @team
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to team' do
        get :edit, :id => @team
        response.should be_success
      end

      it 'should assigns the requested team as @team' do
        team = Factory(:team, :id => "30", :email => "tea@team.com")
        get :edit, :id => "30"
        assigns(:team).id.should == 30
      end
    end
  end

  describe "POST 'create'" do
    describe "when user not signed in" do
      it 'should deny access' do
        team = Factory.build(:team, 
                             :email => "not_signed_team@team.com",
                             :name => "not signed in")
        post :create, :team => team.attributes
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when unauthorized user signed in" do
      
      login_user

      describe "team signup failure" do

        before(:each) do
          @attributes = { :name => "team-team", 
                          :email => "team@team.com",
                          :role => 1 }
          @team = Factory.build(:team)
        end

        it 'should not create team' do
          lambda do
            post :create, :team => @attributes
          end.should_not change(Team, :count)
        end

        it "should render the 'new' action" do
          post :create, :team => @attributes
          response.should redirect_to root_path
        end
      end

      describe "team signup success" do

        login_privileged

        before(:each) do
          @attributes = { :name => "team-team", 
                          :email => "team@team.com",
                          :role => 1 }
          @team = Factory.build(:team)
        end

        it 'should not save a team with false params' do
          team = Factory.build(:team, :email => nil)
          post :create, :team => team.attributes
          assigns(:team).save.should_not  be_true
        end

         it "should render the 'new' action" do
          post :create, :team => {:role => 90}
          response.should render_template :new
        end

        it 'should create new team' do
          lambda do
            post :create, :team => @attributes
          end.should change(Team, :count).by(1)
        end

        it 'should assigns a newly created team as @team' do
          post :create, :team => @team.attributes
          assigns(:team).name.should == @team.name
        end

        it 'should redirect to the show action' do
          post :create, :team => @team.attributes
          response.should redirect_to(team_path(assigns(:team)))
        end
      end
    end
  end
  
  describe "PUT 'update'" do

    before(:each) do
      @team = Factory(:team)
      @attributes = { :name => "update team",
                      :email => "update_team@example.com",
                      :role => 3 }
    end

    describe "when user not signed in" do

      it 'should deny access' do
        put :update, :id => @team, :team => @attributes
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do
      login_user

      describe "failure" do
        it 'should render edit page' do
          put :update, :id => @team, :team => {:email => nil}
          response.should render_template(:edit)
        end
      end

      describe "success" do
        it "should change the user's attributes" do
          put :update, :id => @team, :team => @attributes
          @team.reload
          @team.name.should == @attributes[:name]
          @team.email.should == @attributes[:email]
          @team.role.should == @attributes[:role]
        end

        it 'should redirect to team show page' do
          put :update, :id => @team, :team => @attributes
          response.should redirect_to(team_path(@team))
        end
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @team = Factory(:team)
    end

    describe "when user not signed in" do
      it 'should deny access' do
        delete :destroy, :id => @team
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do
      
      describe "not authorized" do

        login_user

        it 'should not delete user' do
          lambda do
            delete :destroy, :id => @team
          end.should_not change(Team, :count)
        end

        it 'should redirect to home page' do
          delete :destroy, :id => @team
          response.should redirect_to(root_path)
        end
      end

      describe "authorized" do

        login_privileged

        it 'should delete user' do
          lambda do
            delete :destroy, :id => @team
          end.should change(Team, :count).by(-1)
        end
        
        it 'should redirect to team page' do
          delete :destroy, :id => @team
          response.should redirect_to(teams_path)
        end
      end
    end
  end

end
