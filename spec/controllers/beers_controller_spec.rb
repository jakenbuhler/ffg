require 'spec_helper'

describe BeersController do

  def mock_beer(stubs={})
    (@mock_beer ||= mock_model(Beer).as_null_object).tap do |beer|
      beer.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all beers as @beers" do
      Beer.stub(:all) { [mock_beer] }
      get :index
      assigns(:beers).should eq([mock_beer])
    end
  end

  describe "GET show" do
    it "assigns the requested beer as @beer" do
      Beer.stub(:find).with("37") { mock_beer }
      get :show, :id => "37"
      assigns(:beer).should be(mock_beer)
    end
  end

  describe "GET new" do
    it "assigns a new beer as @beer" do
      Beer.stub(:new) { mock_beer }
      get :new
      assigns(:beer).should be(mock_beer)
    end
  end

  describe "GET edit" do
    it "assigns the requested beer as @beer" do
      Beer.stub(:find).with("37") { mock_beer }
      get :edit, :id => "37"
      assigns(:beer).should be(mock_beer)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created beer as @beer" do
        Beer.stub(:new).with({'these' => 'params'}) { mock_beer(:save => true) }
        post :create, :beer => {'these' => 'params'}
        assigns(:beer).should be(mock_beer)
      end

      it "redirects to the created beer" do
        Beer.stub(:new) { mock_beer(:save => true) }
        post :create, :beer => {}
        response.should redirect_to(beer_url(mock_beer))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved beer as @beer" do
        Beer.stub(:new).with({'these' => 'params'}) { mock_beer(:save => false) }
        post :create, :beer => {'these' => 'params'}
        assigns(:beer).should be(mock_beer)
      end

      it "re-renders the 'new' template" do
        Beer.stub(:new) { mock_beer(:save => false) }
        post :create, :beer => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested beer" do
        Beer.should_receive(:find).with("37") { mock_beer }
        mock_beer.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :beer => {'these' => 'params'}
      end

      it "assigns the requested beer as @beer" do
        Beer.stub(:find) { mock_beer(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:beer).should be(mock_beer)
      end

      it "redirects to the beer" do
        Beer.stub(:find) { mock_beer(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(beer_url(mock_beer))
      end
    end

    describe "with invalid params" do
      it "assigns the beer as @beer" do
        Beer.stub(:find) { mock_beer(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:beer).should be(mock_beer)
      end

      it "re-renders the 'edit' template" do
        Beer.stub(:find) { mock_beer(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested beer" do
      Beer.should_receive(:find).with("37") { mock_beer }
      mock_beer.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the beers list" do
      Beer.stub(:find) { mock_beer }
      delete :destroy, :id => "1"
      response.should redirect_to(beers_url)
    end
  end

end
