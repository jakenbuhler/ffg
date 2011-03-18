class TastingsController < ApplicationController
  before_filter :authenticate

  def index
    @tastings = Tasting.all
    @title = "Tastings"
  end

  def show
    @tasting = Tasting.find(params[:id])
    @title = "Tasting of #{@tasting.beer.name}"
  end

  def new
    @tasting = Tasting.new
    @title = "New Tasting"
  end

  def edit
    @tasting = Tasting.find(params[:id])
    @title = 'Edit Tasting'
  end

  def create
    @tasting = Tasting.new(params[:tasting])
    if @tasting.save
      flash[:success] = 'Tasting was successfully created.'
      redirect_to @tasting
    else
      @title = 'New Tasting'
      render "new"
    end
  end

  def update
    @tasting = Tasting.find(params[:id])
    if @tasting.update_attributes(params[:tasting])
      flash[:success] = 'Tasting has been updated.'
      redirect_to @tasting
    else
      @title = 'Edit Tasting'
      render "edit"
    end
  end

  def destroy
    Tasting.find(params[:id]).destroy
    flash[:success] = 'Tasting has been deleted.'
    redirect_to tastings_path
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
end
