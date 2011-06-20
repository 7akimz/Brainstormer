class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_team, :current_project
  helper_method :team_present?, :project_present?

  # Redirect to the home page if the user is not
  # authorized
  def authorized_user
    redirect_to root_path unless has_privilege?
  end

  #def team_present?
    #if user_signed_in? 
     # redirect_to root_path unless current_team
    #else
      #flash[:notice] = "You must be signed in"
     # redirect_to new_user_session_path
    #end
  #end

  def team_present?
    !current_team.nil?
  end

  def project_present?
    !current_project.nil?
  end

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

    def get_team
      Team.find(session["team_id"]) unless session["team_id"].nil?
    end

    def get_project
      Project.find(session["project_id"]) unless session[
      "project_id"].nil?
    end

end
