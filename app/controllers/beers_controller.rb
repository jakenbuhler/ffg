class BeersController < ApplicationController
  before_filter :authenticate

  def index
    @beers = Beer.all
    @title = "Beers"
  end

  def show
    @beer = Beer.find(params[:id])
    @title = @beer.name
  end

  def new
    @beer = Beer.new
    @title = 'New Beer'
  end

  def edit
    @beer = Beer.find(params[:id])
    @title = 'Edit Beer'
  end

  def create
    @beer = Beer.new(params[:beer])
    if @beer.save
      flash[:success] = 'Beer was successfully created.'
      redirect_to @beer
    else
      @title = 'New Beer'
      render "new"
    end
  end

  def update
    @beer = Beer.find(params[:id])
    if @beer.update_attributes(params[:beer])
      flash[:success] = "Beer has been updated."
      redirect_to @beer
    else
      @title = "Edit Beer"
      render "edit"
    end
  end

  def destroy
    Beer.find(params[:id]).destroy
    flash[:success] = 'Beer has been deleted.'
    redirect_to beers_path
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
end
