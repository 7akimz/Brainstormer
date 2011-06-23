class CompaniesController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!
  before_filter :authorized_user, :only => [:new, :create, :destroy]
  before_filter :get_company, :except => [:index, :create]
  
  def index
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
      @company = params[:id].present? ? Company.find(params[:id]) :
        Company.new
    end
end
