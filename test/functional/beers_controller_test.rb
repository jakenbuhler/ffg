require 'test_helper'

class BeersControllerTest < ActionController::TestCase
  setup do
    @beer = beers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beer" do
    assert_difference('Beer.count') do
      post :create, :beer => @beer.attributes
    end

    assert_redirected_to beer_path(assigns(:beer))
  end

  test "should show beer" do
    get :show, :id => @beer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @beer.to_param
    assert_response :success
  end

  test "should update beer" do
    put :update, :id => @beer.to_param, :beer => @beer.attributes
    assert_redirected_to beer_path(assigns(:beer))
  end

  test "should destroy beer" do
    assert_difference('Beer.count', -1) do
      delete :destroy, :id => @beer.to_param
    end

    assert_redirected_to beers_path
  end
end
