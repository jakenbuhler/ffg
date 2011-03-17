require 'spec_helper'

describe TastingsController do

  def mock_tasting(stubs={})
    (@mock_tasting ||= mock_model(Tasting).as_null_object).tap do |tasting|
      tasting.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all tastings as @tastings" do
      Tasting.stub(:all) { [mock_tasting] }
      get :index
      assigns(:tastings).should eq([mock_tasting])
    end
  end

  describe "GET show" do
    it "assigns the requested tasting as @tasting" do
      Tasting.stub(:find).with("37") { mock_tasting }
      get :show, :id => "37"
      assigns(:tasting).should be(mock_tasting)
    end
  end

  describe "GET new" do
    it "assigns a new tasting as @tasting" do
      Tasting.stub(:new) { mock_tasting }
      get :new
      assigns(:tasting).should be(mock_tasting)
    end
  end

  describe "GET edit" do
    it "assigns the requested tasting as @tasting" do
      Tasting.stub(:find).with("37") { mock_tasting }
      get :edit, :id => "37"
      assigns(:tasting).should be(mock_tasting)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created tasting as @tasting" do
        Tasting.stub(:new).with({'these' => 'params'}) { mock_tasting(:save => true) }
        post :create, :tasting => {'these' => 'params'}
        assigns(:tasting).should be(mock_tasting)
      end

      it "redirects to the created tasting" do
        Tasting.stub(:new) { mock_tasting(:save => true) }
        post :create, :tasting => {}
        response.should redirect_to(tasting_url(mock_tasting))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tasting as @tasting" do
        Tasting.stub(:new).with({'these' => 'params'}) { mock_tasting(:save => false) }
        post :create, :tasting => {'these' => 'params'}
        assigns(:tasting).should be(mock_tasting)
      end

      it "re-renders the 'new' template" do
        Tasting.stub(:new) { mock_tasting(:save => false) }
        post :create, :tasting => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested tasting" do
        Tasting.should_receive(:find).with("37") { mock_tasting }
        mock_tasting.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tasting => {'these' => 'params'}
      end

      it "assigns the requested tasting as @tasting" do
        Tasting.stub(:find) { mock_tasting(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tasting).should be(mock_tasting)
      end

      it "redirects to the tasting" do
        Tasting.stub(:find) { mock_tasting(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tasting_url(mock_tasting))
      end
    end

    describe "with invalid params" do
      it "assigns the tasting as @tasting" do
        Tasting.stub(:find) { mock_tasting(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tasting).should be(mock_tasting)
      end

      it "re-renders the 'edit' template" do
        Tasting.stub(:find) { mock_tasting(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested tasting" do
      Tasting.should_receive(:find).with("37") { mock_tasting }
      mock_tasting.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tastings list" do
      Tasting.stub(:find) { mock_tasting }
      delete :destroy, :id => "1"
      response.should redirect_to(tastings_url)
    end
  end

end
