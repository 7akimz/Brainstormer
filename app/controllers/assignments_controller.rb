class AssignmentsController < ApplicationController

  respond_to :html, :js
  
  before_filter :authorized_user
  before_filter :check_team_presence

  # Assign a project to a team by adding their IDs
  # in the join table
  def create
    @project = Project.find(params[:assignment][:project_id])
    current_team.assign_to!(@project)
    respond_with(@project)
  end

  # Delete the relation between a project and a team
  # by removing their records from the join table
  def destroy
    @project = Assignment.find(params[:id]).project
    current_team.unassign_from!(@project)
    respond_with(@project)
  end

end
