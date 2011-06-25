class CompaniesController < ApplicationController

  respond_to :html

  # Those filters is executed before actions
  before_filter :authenticate_user!
  before_filter :authorized_user, :only => [:new, :create, :destroy]
  before_filter :get_company, :except => [:index, :create]
  # This filter is executed after an action execution
  after_filter :add_to_team, :only => [:create]
  
  # Pre-conditions  : user must be logged in
  # Post-conditions : All companies is displayed in 
  # the index page of a company
  def index
    # Get all of the companies and assign them
    # to @companies instance varible
    @companies = Company.all
  end

  def show; end

  def new; end

  def edit; end

  def create
    @company = Company.new(params[:company])

    if @company.save
      flash[:notice] = "New company is created"
      respond_with(@company)
    else
      flash[:alert] = "Error!!"
      render :new
    end
  end

  def update
    if @company.update_attributes(params[:company])
      flash[:notice] = "Attributes has been updated!"
      respond_with(@company)
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    flash[:notice] = "Company deleted!!"
    respond_with(@company)
  end

  private

    def get_company
      @company = params[:id].present? ? Company.find(
        params[:id]) : Company.new
    end

    def add_to_team
      unless session["team_id"].nil?
        team = Team.find(session["team_id"])
        team.work_in!(@company) if @company.save
      end
    end
end
