class TeamsController < ApplicationController

  respond_to :html

  # This fuctions is executed before executing the actions
  before_filter :get_post, :except => [:index, :create]
  before_filter :authorized_user, :only => [:destroy, :create]
  before_filter :authenticate_user!, :except => [:destroy, :create]

  # This function is executed after executing the action
  after_filter :add_members, :only => :create

  # Pre-conditions : User must be signed in
  def index
    @teams = Team.all 
  end

  # Pre-conditions : User must be signed in
  def show
    session[:team_id] = @team.id
  end

  # Pre-conditions : User must be signed in
  def new; end
  
  # Pre-conditions : User must be signed in
  def edit; end

  # Pre-conditions : User must be signed in
  # Post-conditions : New Team is created in the database
  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = "Team Created!!"
      respond_with(@team)
    else
      flash[:alert] = "Error!!"
      render :new
    end
  end

  # Pre-conditions : User must be signed in
  # Post-conditions : Team value updated in the database
  def update
    if @team.update_attributes(params[:team])
      flash[:notice] = "Team Updated!!"
      respond_with(@team)
    else
      render :edit
    end
  end

  # Pre-conditions : User must be signed in and authorized
  # to delete. 
  # Post-conditions : Team are deleted in the database
  def destroy
    @team.destroy
    flash[:notice] = "Team Deleted!!!"
    respond_with(@team)
  end

  private
     
    # Return the team if the id where found return
    # an instance of Team
    def get_post
      @team = params[:id].present? ? Team.find(params[:id]) : Team.new
    end

    def add_members
      current_user.teams << @team if @team.save
    end
end
