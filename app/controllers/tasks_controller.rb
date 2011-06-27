class TasksController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!
  before_filter :get_project
  before_filter :get_task, :except => [:index, :create]

  def index
    @tasks = @project.tasks
    respond_with(@project, @tasks)
  end

  def show; end

  def new; end

  def edit; end

  def create
    @task = @project.tasks.build(params[:task])
    if @task.save
      flash[:notice] = "Task created!!"
      respond_with(@project, @task)
    else
      flash[:error] = "An error occurred while creating"
      render :new
    end
  end
  
  def update
    if @task.update_attributes(params[:task])
      flash[:notice] = "Task updated!!!"
      respond_with(@project, @task)
    else
      flash[:error] = "An error occurred while updating"
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task been deleted!!"
    respond_with(@project, @task)
  end

  private

    def get_task
      @task = params[:id].present? ? @project.tasks.find(
        params[:id]) : Task.new
    end

    def get_project
      @project = Project.find(params[:project_id]) if params[
        :project_id].present?
    end
end
