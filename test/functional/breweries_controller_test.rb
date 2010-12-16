require 'test_helper'

class BreweriesControllerTest < ActionController::TestCase
  setup do
    @brewery = breweries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:breweries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brewery" do
    assert_difference('Brewery.count') do
      post :create, :brewery => @brewery.attributes
    end

    assert_redirected_to brewery_path(assigns(:brewery))
  end

  test "should show brewery" do
    get :show, :id => @brewery.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @brewery.to_param
    assert_response :success
  end

  test "should update brewery" do
    put :update, :id => @brewery.to_param, :brewery => @brewery.attributes
    assert_redirected_to brewery_path(assigns(:brewery))
  end

  test "should destroy brewery" do
    assert_difference('Brewery.count', -1) do
      delete :destroy, :id => @brewery.to_param
    end

    assert_redirected_to breweries_path
  end
end
