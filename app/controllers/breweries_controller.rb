class BreweriesController < ApplicationController
  # GET /breweries
  # GET /breweries.xml
  def index
    @breweries = Brewery.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @breweries }
    end
  end

  # GET /breweries/1
  # GET /breweries/1.xml
  def show
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @brewery }
    end
  end

  # GET /breweries/new
  # GET /breweries/new.xml
  def new
    @brewery = Brewery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @brewery }
    end
  end

  # GET /breweries/1/edit
  def edit
    @brewery = Brewery.find(params[:id])
  end

  # POST /breweries
  # POST /breweries.xml
  def create
    @brewery = Brewery.new(params[:brewery])

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to(@brewery, :notice => 'Brewery was successfully created.') }
        format.xml  { render :xml => @brewery, :status => :created, :location => @brewery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @brewery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /breweries/1
  # PUT /breweries/1.xml
  def update
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      if @brewery.update_attributes(params[:brewery])
        format.html { redirect_to(@brewery, :notice => 'Brewery was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @brewery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.xml
  def destroy
    @brewery = Brewery.find(params[:id])
    @brewery.destroy

    respond_to do |format|
      format.html { redirect_to(breweries_url) }
      format.xml  { head :ok }
    end
  end
end
