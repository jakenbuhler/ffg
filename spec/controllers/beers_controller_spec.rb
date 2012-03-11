require 'spec_helper'

describe BeersController do
  render_views

  before(:each) do
    @stub_beer = stub_model(Beer, :brewery => stub_model(Brewery))
  end
  
  describe "for signed-in users" do
    before(:each) do
      test_sign_in(Factory(:user))
    end

    describe "GET index" do
      it "assigns all beers as @beers" do
        Beer.stub(:all) { [@stub_beer] }
        get :index
        assigns(:beers).should eq([@stub_beer])
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
        Beer.stub(:all) { [@stub_beer] }
        get :index
        response.should have_selector('tr', :content => @stub_beer.name)
        response.should have_selector('tr', :content => @stub_beer.brewery.name)
        response.should have_selector('a', :href => beer_path(@stub_beer))
      end
    end

    describe "GET show" do
      before(:each) do
        Beer.stub(:find).with(@stub_beer.id) { @stub_beer }
        get :show, :id => @stub_beer.id
      end
      
      it "assigns the requested beer as @beer" do
        assigns(:beer).should be(@stub_beer)
      end

      it "should have the right title" do
        response.should have_selector('title', :content => @stub_beer.name)
      end

      it "should contain an edit link" do
        response.should have_selector('a', :href => edit_beer_path(@stub_beer))
      end

      it "should contain an delete link" do
        response.should have_selector(
          'a', :href => beer_path(@stub_beer), :content => 'delete')
      end
    end

    describe "GET new" do
      it "assigns a new beer as @beer" do
        Beer.stub(:new) { @stub_beer }
        get :new
        assigns(:beer).should be(@stub_beer)
      end

      it "should have the right title" do
        get :new
        response.should have_selector('title', :content => 'New Beer')
      end
    end

    describe "GET edit" do
      before(:each) do
        Beer.stub(:find).with(@stub_beer.id) { @stub_beer }
        get :edit, :id => @stub_beer.id
      end
      
      it "assigns the requested beer as @beer" do
        assigns(:beer).should be(@stub_beer)
      end

      it "should have the right title" do
        response.should have_selector('title', :content => 'Edit Beer')
      end
    end

    describe "POST create" do

      describe "with valid params" do
        before(:each) do
          @valid_new_beer = stub_model(Beer, :save => true)
        end
        
        it "assigns a newly created beer as @beer" do
          Beer.stub(:new).with({'these' => 'params'}) { @valid_new_beer }
          post :create, :beer => {'these' => 'params'}
          assigns(:beer).should be(@valid_new_beer)
        end

        it "redirects to the created beer" do
          Beer.stub(:new) { @valid_new_beer }
          post :create, :beer => {}
          response.should redirect_to(beer_url(@valid_new_beer))
        end

        it "should flash a success confirmation" do
          Beer.stub(:new) { @valid_new_beer }
          post :create, :beer => {}
          flash[:success].should =~ /created/i
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_beer = stub_model(Beer, :save => false)
        end
        
        it "assigns a newly created but unsaved beer as @beer" do
          Beer.stub(:new).with({'these' => 'params'}) { @invalid_beer }
          post :create, :beer => {'these' => 'params'}
          assigns(:beer).should be(@invalid_beer)
        end

        it "re-renders the 'new' template" do
          Beer.stub(:new) { @invalid_beer }
          post :create, :beer => {}
          response.should render_template("new")
        end

        it "displays the correct title" do
          Beer.stub(:new) { @invalid_beer }
          post :create, :beer => {}
          response.should have_selector("title", :content => 'New Beer')
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        before(:each) do
          @updated_beer = stub_model(Beer, :update_attributes => true)
        end
        
        it "updates the requested beer" do
          Beer.should_receive(:find).with(@updated_beer.id) { @updated_beer }
          @updated_beer.should_receive(:update_attributes).with(
            {'these' => 'params'})
          put :update, :id => @updated_beer.id, :beer => {'these' => 'params'}
        end

        it "assigns the requested beer as @beer" do
          Beer.stub(:find) { @updated_beer }
          put :update, :id => @updated_beer.id
          assigns(:beer).should be(@updated_beer)
        end

        it "redirects to the beer" do
          Beer.stub(:find) { @updated_beer }
          put :update, :id => @updated_beer.id
          response.should redirect_to(beer_url(@updated_beer))
        end

        it "should give confirmation" do
          Beer.stub(:find) { @updated_beer }
          put :update, :id => @updated_beer.id
          flash[:success].should =~ /updated/i
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_beer = stub_model(Beer, :update_attributes => false)
        end
        
        it "assigns the beer as @beer" do
          Beer.stub(:find) { @invalid_beer }
          put :update, :id => @invalid_beer.id
          assigns(:beer).should be(@invalid_beer)
        end

        it "re-renders the 'edit' template" do
          Beer.stub(:find) { @invalid_beer }
          put :update, :id => @invalid_beer.id
          response.should render_template("edit")
        end

        it "displays the correct title" do
          Beer.stub(:find) { @invalid_beer }
          put :update, :id => @invalid_beer.id
          response.should have_selector("title", :content => 'Edit Beer')
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested beer" do
        Beer.should_receive(:find).with(@stub_beer.id) { @stub_beer }
        @stub_beer.should_receive(:destroy)
        delete :destroy, :id => @stub_beer.id
      end

      it "redirects to the beers list" do
        Beer.stub(:find) { @stub_beer }
        delete :destroy, :id => @stub_beer
        response.should redirect_to(beers_url)
      end

      it "should display confirmation" do
        Beer.stub(:find) { @stub_beer }
        delete :destroy, :id => @stub_beer.id
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
        Beer.stub(:find).with("37") { stub_model(Beer) }
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
        Beer.stub(:find).with("37") { stub_model(Beer) }
        get :edit, :id => "37"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "POST create" do
      it "should deny access" do
        Beer.stub(:new).with({'these' => 'params'}) { stub_model(Beer, :save => true) }
        post :create, :beer => {'these' => 'params'}
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "PUT update" do
      it "should deny access" do
        Beer.stub(:find) { stub_model(Beer, :update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "DELETE destroy" do
      it "should deny access" do
        Beer.stub(:find) { stub_model(Beer) }
        delete :destroy, :id => "1"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
  end
end
