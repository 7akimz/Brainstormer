class TeamsController < ApplicationController

  respond_to :html, :js

  before_filter :get_post, :except => [:index, :create]
  before_filter :authenticate_user!, :except => :index 

  def index
    @teams = Team.all 
  end

  def show

  end

  def new

  end
  
  def edit

  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = "Team Created!!"
      respond_with(@team)
    else
      render :new
    end
  end

  def update
    @team.update_attributes(params[:team])
    respond_with(@team) 
  end

  def destroy
    @team = Team.find(params[:id]).destroy
    flash[:notice] = "Team Deleted!!!"
    respond_with(@team)
  end

  private
    def get_post
      @team = params[:id].present? ? Team.find(params[:id]) : Team.new
    end
  
end
