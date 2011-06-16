class MembersController < ApplicationController

  respond_to :html, :js

  before_filter :authenticate_user!

  def create
    @team = Team.find(params[:member][:team_id])
    current_user.want_to_join!(@team)
    respond_with @team
  end

  def destroy
    @team = Member.find(params[:id]).team
    current_user.want_to_leave!(@team) 
    respond_with @team
  end

end
