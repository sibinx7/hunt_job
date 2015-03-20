require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get user" do
    get :user
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

  test "should get project" do
    get :project
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

  test "should get bids" do
    get :bids
    assert_response :success
  end

  test "should get bid" do
    get :bid
    assert_response :success
  end

  test "should get payments" do
    get :payments
    assert_response :success
  end

end
