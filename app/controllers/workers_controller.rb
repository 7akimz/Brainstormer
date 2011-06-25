class WorkersController < ApplicationController
  respond_to :html, :js

  before_filter :authenticate_user!
  before_filter :check_team_presence

  # Assign a company to a team by adding their IDs
  # in the join table
  def create
    @company = Company.find(params[:worker][:company_id])
    current_team.work_in!(@company)
    respond_with(@company)
  end

  # Delete the relation between a company and a team
  # by removing their records from the join table
  def destroy
    @company = Worker.find(params[:id]).company
    current_team.retire_from!(@company)
    respond_with(@company)
  end
end
