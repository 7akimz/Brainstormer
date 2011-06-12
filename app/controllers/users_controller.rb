class UsersController < ApplicationController
  respond_to :html, :js

  before_filter :authenticate_user!
  
  def index
    @users = User.all
    respond_with(@users)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    respond_with(@user)
  end
  
end
