require 'spec_helper'

describe CompaniesController do

  before(:each) do
    @company = Factory(:company)
  end

  describe "GET 'index'" do

    describe "when user not signed in" do
      it 'should deny access to index' do
        get :index
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to index' do
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

      it 'should assign all companies as @companies' do
        companies = Company.all
        get :index
        assigns(:companies).should eq companies
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
        get :show, :id => @company
        response.should be_success
      end

      it 'should get the correct company' do
        company = Factory(:company, :name => "show", :id => "5")
        get :show, :id => 5
        assigns(:company).id.should == 5
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

        it 'should not assigns new company as @company' do
          get :new
          assigns(:company).should be nil
        end
      end

      describe "for privileged users" do

        login_privileged

         it 'should respond to the new' do
          get :new
          response.should be_success
        end

        it 'should assigns new company as @company' do
          get :new
          assigns(:company).should_not be nil
        end

      end
            
    end
  end

  describe "GET 'edit'" do

    describe "when user not signed in" do

      it 'should deny access' do
        get :edit, :id => @company
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to edit' do
        get :edit, :id => @company
        response.should_not be_success
      end
    end

    describe "when user signed in" do
      login_user

      it 'should respond to company' do
        get :edit, :id => @company
        response.should be_success
      end

      it 'should assigns the requested company as @company' do
        company = Factory(:company, :id => '5', :name => "edit") 
        get :edit, :id => '5'
        assigns(:company).id.should == 5
      end
    end
  end

  describe "POST 'create'" do

    describe "when user not signed in" do

      it 'should deny access' do
        post :create, :company => @company.attributes
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "when user signed in" do

      describe "for non privileged user" do

        login_user

        it 'should not respond to create' do
          post :create, :company => @company.attributes
          response.should redirect_to(root_path)
        end
      end

      describe "for privileged user" do

        login_privileged

        it 'should not create a company with false params' do
          @company.name = ""
          post :create, :company => @company.attributes
          assigns(:company).save.should_not be_true
        end

        it 'should render the new action' do
          @company.capital = ""
          post :create, :company => @company.attributes
          response.should render_template :new
        end

        it 'should assigns new company as @company' do
          post :create, :company => @company.attributes
          assigns(:company).name.should == @company.name
        end

        it 'should increase the database record by 1' do
          @company.name = "My Company"
          @company.email = "mycompany@company.com"
          lambda do
            post :create, :company => @company.attributes
          end.should change(Company, :count).by(1)
        end

        it 'should redirect to show action' do
          @company.name = "Re Company"
          @company.email = "recompany@company.com"
          post :create, :company => @company.attributes
          response.should redirect_to(company_path(
            assigns(:company)))
        end
      end
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @attributes = {
        :name  =>"test",
        :email => "com@com.com",
        :telephone => "0101111111",
        :country => 2,
        :address => "nasr city",
        :capital => 2000.0,
      }

    end

    describe "when user not signed in" do

      it 'should deny access' do
        put :update, :id => @company, :company => @attributes
        response.should redirect_to(new_user_session_path)
      end

      it 'should not respond to update' do
        put :update, :id => @company, :company => @attributes
        response.should_not be_success
      end
    end

    describe "when user signed in" do

      login_user

      it 'should not update invalid attribute' do
        @attributes[:name] = ""
        put :update, :id => @company, :company => @attributes
        response.should render_template(:edit)
      end

      it 'should update attributes' do
        put :update, :id => @company, :company => @attributes
        @company.reload
        @company.name.should == @attributes[:name]
        @company.email.should == @attributes[:email]
        @company.capital.should == @attributes[:capital]
        @company.address.should == @attributes[:address]
      end

      it 'should redirect to show page' do
        put :update, :id => @company, :company => @company.attributes
        response.should redirect_to(company_path(@company))
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

        it 'should not delete company' do
          lambda do
            delete :destroy, :id => @company
          end.should_not change(Company, :count)
        end

        it 'should redirect to home page' do
          delete :destroy, :id => @company
          response.should redirect_to root_path
        end
      end

      describe "has privilege" do

        login_privileged

        it 'should delete user' do
          lambda do
            delete :destroy, :id => @company
          end.should change(Company, :count).by(-1)
        end

        it 'should redirect to companies page' do
          delete :destroy, :id => @company
          response.should redirect_to companies_path
        end
      end
    end
  end

  
end
