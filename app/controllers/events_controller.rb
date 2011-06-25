class EventsController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!
  before_filter :get_team
  before_filter :get_event, :except => [:index, :create]

  def index
    @events = @team.events
    respond_with(@team, @events)
  end

  def show; end

  def new; end

  def edit; end

  def create
    @event = @team.events.build(params[:event])
    if @event.save
      flash[:notice] = "Event created!!"
      respond_with(@team, @event)
    else
      flash[:error] = "An error occurred while creating"
      render :new
    end
  end
  
  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Event updated!!!"
      respond_with(@team, @event)
    else
      flash[:error] = "An error occurred while updating"
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "Event been deleted!!"
    respond_with(@team, @event)
  end

  private

    def get_event
      @event = params[:id].present? ? @team.events.find(
        params[:id]) : Event.new
    end

    def get_team
      @team = Team.find(params[:team_id]) if params[
        :team_id].present?
    end
end
