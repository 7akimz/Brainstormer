class AssignmentsController < ApplicationController

  respond_to :html, :js
  
  before_filter :authorized_user
  before_filter :check_team_presence


  def create
    @project = Project.find(params[:assignment][:project_id])
    current_team.assign_to!(@project)
    respond_with(@project)
  end

  def destroy
    @project = Assignment.find(params[:id]).project
    current_team.unassign_from!(@project)
    respond_with(@project)
  end

  private

    def check_team_presence
      redirect_to root_path unless team_present?
    end

end
