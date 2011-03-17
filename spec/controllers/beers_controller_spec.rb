require 'spec_helper'

describe BeersController do
  render_views
  
  def mock_beer(stubs={})
    (@mock_beer ||= mock_model(Beer).as_null_object).tap do |beer|
      beer.stub(stubs) unless stubs.empty?
    end
  end

  describe "for signed-in users" do
    before(:each) do
      test_sign_in(Factory(:user))
    end

    describe "GET index" do
      it "assigns all beers as @beers" do
        Beer.stub(:all) { [mock_beer] }
        get :index
        assigns(:beers).should eq([mock_beer])
      end
      
      it 'should have the right title' do
        get :index
        response.should have_selector("title", :content => "Beers")
        response.should have_selector('h2', :content => 'Beers')
      end
      
      it 'should have a link to create a new beer' do
        get :index
        response.should have_selector("a", :href => new_beer_path)
      end
      
      it 'should contain a table row for each beer' do
        brewery = mock_model(Brewery).as_null_object
        brewery.stub(:name => 'My Brewery')
        Beer.stub(:all) { [mock_beer(:name => 'My Beer', :brewery => brewery)] }
        get :index
        response.should have_selector('tr', :content => mock_beer.name)
        response.should have_selector('tr', :content => brewery.name)
        response.should have_selector('a', :href => beer_path(mock_beer))
      end
    end

    describe "GET show" do
      it "assigns the requested beer as @beer" do
        Beer.stub(:find).with("37") { mock_beer }
        get :show, :id => "37"
        assigns(:beer).should be(mock_beer)
      end

      it "should have the right title" do
        id = '1'
        name = 'Pliny the Middle Aged'
        Beer.stub(:find).with(id) { mock_beer(:name => name) }
        get :show, :id => id
        response.should have_selector('title', :content => name)
      end

      it "should contain an edit link" do
        id = '1'
        Beer.stub(:find).with(id) { mock_beer }
        get :show, :id => id
        response.should have_selector('a', :href => edit_beer_path(mock_beer))
      end

      it "should contain an delete link" do
        id = '1'
        Beer.stub(:find).with(id) { mock_beer }
        get :show, :id => id
        response.should have_selector('a', :href => beer_path(mock_beer),
                                           :content => 'delete')
      end
    end

    describe "GET new" do
      it "assigns a new beer as @beer" do
        Beer.stub(:new) { mock_beer }
        get :new
        assigns(:beer).should be(mock_beer)
      end

      it "should have the right title" do
        get :new
        response.should have_selector('title', :content => 'New Beer')
      end
    end

    describe "GET edit" do
      it "assigns the requested beer as @beer" do
        Beer.stub(:find).with("37") { mock_beer }
        get :edit, :id => "37"
        assigns(:beer).should be(mock_beer)
      end

      it "should have the right title" do
        Beer.stub(:find).with("37") { mock_beer }
        get :edit, :id => "37"
        response.should have_selector('title', :content => 'Edit Beer')
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

        it "should flash a success confirmation" do
          Beer.stub(:new) { mock_beer(:save => true) }
          post :create, :beer => {}
          flash[:success].should =~ /created/i
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

        it "displays the correct title" do
          Beer.stub(:new) { mock_beer(:save => false) }
          post :create, :beer => {}
          response.should have_selector("title", :content => 'New Beer')
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

        it "should give confirmation" do
          Beer.stub(:find) { mock_beer(:update_attributes => true) }
          put :update, :id => "1"
          flash[:success].should =~ /updated/i
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

        it "displays the correct title" do
          Beer.stub(:find) { mock_beer(:update_attributes => false) }
          put :update, :id => "1"
          response.should have_selector("title", :content => 'Edit Beer')
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

      it "should display confirmation" do
        Beer.stub(:find) { mock_beer }
        delete :destroy, :id => "1"
        flash[:success].should =~ /deleted/i
      end
    end
  end

  describe "for non-signed-in users" do
    describe "GET index" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "GET show" do
      it "should deny access" do
        Beer.stub(:find).with("37") { mock_beer }
        get :show, :id => "37"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "GET new" do
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "GET edit" do
      it "should deny access" do
        Beer.stub(:find).with("37") { mock_beer }
        get :edit, :id => "37"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "POST create" do
      it "should deny access" do
        Beer.stub(:new).with({'these' => 'params'}) { mock_beer(:save => true) }
        post :create, :beer => {'these' => 'params'}
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "PUT update" do
      it "should deny access" do
        Beer.stub(:find) { mock_beer(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "DELETE destroy" do
      it "should deny access" do
        Beer.stub(:find) { mock_beer }
        delete :destroy, :id => "1"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
  end
end
