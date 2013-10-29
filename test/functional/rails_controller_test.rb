require 'test_helper'

class RailsControllerTest < ActionController::TestCase
  test "should get g" do
    get :g
    assert_response :success
  end

  test "should get model" do
    get :model
    assert_response :success
  end

  test "should get WishVideo" do
    get :WishVideo
    assert_response :success
  end

end
