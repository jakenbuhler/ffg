class BreweriesController < ApplicationController
  before_filter :authenticate
  
  def index
    @breweries = Brewery.all
    @title = "Breweries"
  end
  
  def new
    @brewery = Brewery.new
    @title = "New Brewery"
  end
  
  def create
    @brewery = Brewery.new(params[:brewery])
    if @brewery.save
      flash[:success] = "New brewery! We should go on a field trip."
      redirect_to @brewery
    else
      @title = "New Brewery"
      render "new"
    end
  end
  
  def show
    @brewery = Brewery.find(params[:id])
    @title = @brewery.name
  end
  
  def edit
    @brewery = Brewery.find(params[:id])
    @title = "Edit Brewery"
  end
  
  def update
    @brewery = Brewery.find(params[:id])
    if @brewery.update_attributes(params[:brewery])
      flash[:success] = "Brewery has been updated."
      redirect_to @brewery
    else
      @title = "Edit Brewery"
      render 'edit'
    end
  end
  
  def destroy
    Brewery.find(params[:id]).destroy
    flash[:success] = "Brewery has been deleted."
    redirect_to breweries_path
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
end
