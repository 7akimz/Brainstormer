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

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def my_teams
    #@user = User.find(params[:id])
    @teams = current_user.teams
  end
  
end
