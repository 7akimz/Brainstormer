class RelationshipsController < ApplicationController

  respond_to :html, :js

  # Run the authenticate method before each action
  before_filter :authenticate_user!

  # Pre condition : User must be signed in
  # It create an entry in the relationship 
  # model to identify users following
  # another
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end

  # Pre condition : User must be signed in
  # It delete an entry from the relationship 
  # model to destroy following one user to the
  # other
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end


end
