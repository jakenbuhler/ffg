require 'spec_helper'

describe TastingsController do
  before(:each) do
    @stub_tasting = stub_model(Tasting, :beer => stub_model(Beer))
  end
  
  describe "for signed-in users" do
    before(:each) do
      test_sign_in(Factory(:user))
    end
    
    describe "GET new" do
      it "assigns a new tasting as @tasting" do
        Tasting.stub(:new) { @stub_tasting }
        get :new
        assigns(:tasting).should be(@stub_tasting)
      end
    end

    describe "GET edit" do
      it "assigns the requested tasting as @tasting" do
        Tasting.stub(:find).with(@stub_tasting.id) { @stub_tasting }
        get :edit, :id => @stub_tasting.id
        assigns(:tasting).should be(@stub_tasting)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        before(:each) do
          @valid_tasting = stub_model(
            Tasting, :save => true, :beer => stub_model(Beer))
        end
        
        it "assigns a newly created tasting as @tasting" do
          Tasting.stub(:new).with({'these' => 'params'}) { @valid_tasting }
          post :create, :tasting => {'these' => 'params'}
          assigns(:tasting).should be(@valid_tasting)
        end

        it "redirects to the new tasting's beer" do
          Tasting.stub(:new) { @valid_tasting }
          post :create, :tasting => {}
          response.should redirect_to(beer_url(@valid_tasting.beer))
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_tasting = stub_model(Tasting, :save => false)
        end
        
        it "assigns a newly created but unsaved tasting as @tasting" do
          Tasting.stub(:new).with({'these' => 'params'}) { @invalid_tasting }
          post :create, :tasting => {'these' => 'params'}
          assigns(:tasting).should be(@invalid_tasting)
        end

        it "re-renders the 'new' template" do
          Tasting.stub(:new) { @invalid_tasting }
          post :create, :tasting => {}
          response.should render_template("new")
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        before(:each) do
          @valid_tasting = stub_model(
            Tasting, :update_attributes => true, :beer => stub_model(Beer))
        end
        
        it "updates the requested tasting" do
          Tasting.should_receive(:find).with(@valid_tasting.id) { @valid_tasting }
          @valid_tasting.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => @valid_tasting.id, :tasting => {'these' => 'params'}
        end

        it "assigns the requested tasting as @tasting" do
          Tasting.stub(:find) { @valid_tasting }
          put :update, :id => @valid_tasting.id
          assigns(:tasting).should be(@valid_tasting)
        end

        it "redirects to the tasting's beer" do
          Tasting.stub(:find) { @valid_tasting }
          put :update, :id => @valid_tasting.id
          response.should redirect_to(beer_url(@valid_tasting.beer))
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_tasting = stub_model(Tasting, :update_attributes => false)
        end
        
        it "assigns the tasting as @tasting" do
          Tasting.stub(:find) { @invalid_tasting }
          put :update, :id => @invalid_tasting.id
          assigns(:tasting).should be(@invalid_tasting)
        end

        it "re-renders the 'edit' template" do
          Tasting.stub(:find) { @invalid_tasting }
          put :update, :id => @invalid_tasting.id
          response.should render_template("edit")
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested tasting" do
        Tasting.should_receive(:find).with(@stub_tasting.id) { @stub_tasting }
        @stub_tasting.should_receive(:destroy)
        delete :destroy, :id => @stub_tasting.id
      end

      it "redirects to the tastings list" do
        Tasting.stub(:find) { @stub_tasting }
        delete :destroy, :id => @stub_tasting.id
        response.should redirect_to(beer_path(@stub_tasting.beer))
      end
    end
  end

  describe "for non-signed-in users" do
    describe "GET new" do
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "GET edit" do
      it "should deny access" do
        Tasting.stub(:find).with(@stub_tasting.id) { @stub_tasting }
        get :edit, :id => @stub_tasting.id
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "POST create" do
      it "should deny access" do
        stub_tasting = stub_model(Tasting, :save => true)
        Tasting.stub(:new).with({'these' => 'params'}) { stub_tasting }
        post :create, :beer => {'these' => 'params'}
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "PUT update" do
      it "should deny access" do
        stub_tasting = stub_model(Tasting, :update_attributes => true)
        Tasting.stub(:find) { stub_tasting }
        put :update, :id => "1"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "DELETE destroy" do
      it "should deny access" do
        Tasting.stub(:find) { stub_model(Tasting) }
        delete :destroy, :id => "1"
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
  end
end
