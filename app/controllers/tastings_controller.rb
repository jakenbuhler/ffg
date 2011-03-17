class TastingsController < ApplicationController
  # GET /tastings
  # GET /tastings.xml
  def index
    @tastings = Tasting.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tastings }
    end
  end

  # GET /tastings/1
  # GET /tastings/1.xml
  def show
    @tasting = Tasting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tasting }
    end
  end

  # GET /tastings/new
  # GET /tastings/new.xml
  def new
    @tasting = Tasting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tasting }
    end
  end

  # GET /tastings/1/edit
  def edit
    @tasting = Tasting.find(params[:id])
  end

  # POST /tastings
  # POST /tastings.xml
  def create
    @tasting = Tasting.new(params[:tasting])

    respond_to do |format|
      if @tasting.save
        format.html { redirect_to(@tasting, :notice => 'Tasting was successfully created.') }
        format.xml  { render :xml => @tasting, :status => :created, :location => @tasting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tasting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tastings/1
  # PUT /tastings/1.xml
  def update
    @tasting = Tasting.find(params[:id])

    respond_to do |format|
      if @tasting.update_attributes(params[:tasting])
        format.html { redirect_to(@tasting, :notice => 'Tasting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tasting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tastings/1
  # DELETE /tastings/1.xml
  def destroy
    @tasting = Tasting.find(params[:id])
    @tasting.destroy

    respond_to do |format|
      format.html { redirect_to(tastings_url) }
      format.xml  { head :ok }
    end
  end
end
