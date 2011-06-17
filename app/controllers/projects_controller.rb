class ProjectsController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!
  before_filter :authorized_user, :only => [:new, :create, :destroy]
  before_filter :get_project, :except => [:index, :create]
  after_filter  :assign_to_team, :only => [:create]
  
  def index
    @projects = Project.all
  end

  def show
    session["project_id"] = @project.id
  end

  def new;  end

  def edit; end

  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = "New project is create"
      respond_with(@project)
    else
      flash[:alert] = "Error!!"
      render :new
    end
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Attributes has been updated!"
      respond_with(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project deleted!!."
    respond_with(@project) 
  end

  private

    def get_project
      @project = params[:id].present? ? Project.find(params[:id]) :
        Project.new
    end

    def assign_to_team
      unless session["team_id"].nil?
        team = Team.find(session["team_id"]) 
        team.assign_to!(@project) if @project.save
      end
    end
end
