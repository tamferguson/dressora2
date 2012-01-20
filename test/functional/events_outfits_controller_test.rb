require 'test_helper'

class EventsOutfitsControllerTest < ActionController::TestCase
  setup do
    @events_outfit = events_outfits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events_outfits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create events_outfit" do
    assert_difference('EventsOutfit.count') do
      post :create, :events_outfit => @events_outfit.attributes
    end

    assert_redirected_to events_outfit_path(assigns(:events_outfit))
  end

  test "should show events_outfit" do
    get :show, :id => @events_outfit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @events_outfit.to_param
    assert_response :success
  end

  test "should update events_outfit" do
    put :update, :id => @events_outfit.to_param, :events_outfit => @events_outfit.attributes
    assert_redirected_to events_outfit_path(assigns(:events_outfit))
  end

  test "should destroy events_outfit" do
    assert_difference('EventsOutfit.count', -1) do
      delete :destroy, :id => @events_outfit.to_param
    end

    assert_redirected_to events_outfits_path
  end
end
