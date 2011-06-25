class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_team, :current_project
  helper_method :team_present?, :project_present?

  # Redirect to the home page if the user is not
  # authorized
  def authorized_user
    redirect_to root_path unless has_privilege?
  end

  # Redirect to home page unless a team is
  # found
  def check_team_presence
    redirect_to root_path unless team_present?
  end

  # Check if the current team which return an instance 
  # variable is not nil
  def team_present?
    !current_team.nil?
  end

  # If the instance variable @team contains the 
  # team data leave it else get the team from 
  # get_team method and assign it to @team instance 
  # variable
  def current_team
    @team ||= get_team
  end

  def current_project
    @project ||= get_project
  end

  private

    # Check if the user has privilege. Users the have
    # privilege are the managers and team leaders
    def has_privilege?
      if user_signed_in?
        current_user.role == 2 || current_user.role == 5
      else
        flash[:alert] = "You don't have the privilege"
        return redirect_to new_user_session_path
      end
    end

    # Find the team if the session that contains it ID
    # was not nil
    def get_team
      Team.find(session["team_id"]) unless session["team_id"].nil?
    end

end
