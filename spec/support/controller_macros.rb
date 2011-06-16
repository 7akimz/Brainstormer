module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @admin = Factory.create(:user)
      @admin.toggle!(:admin)
      sign_in @admin
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      sign_in @user
    end
  end

  def login_privileged
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user, :role => 2)
      sign_in @user
    end
  end
end
