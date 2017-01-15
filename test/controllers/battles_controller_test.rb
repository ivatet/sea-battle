require 'test_helper'

class BattlesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blank_battles)
    assert_not_nil assigns(:ongoing_battles)
  end

  test "should create battle" do
  end
end
