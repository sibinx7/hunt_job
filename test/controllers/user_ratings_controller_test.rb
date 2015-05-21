require 'test_helper'

class UserRatingsControllerTest < ActionController::TestCase
  setup do
    @user_rating = user_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_rating" do
    assert_difference('UserRating.count') do
      post :create, user_rating: { description: @user_rating.description, project_id: @user_rating.project_id, rated_by: @user_rating.rated_by, rating: @user_rating.rating, user_id: @user_rating.user_id }
    end

    assert_redirected_to user_rating_path(assigns(:user_rating))
  end

  test "should show user_rating" do
    get :show, id: @user_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_rating
    assert_response :success
  end

  test "should update user_rating" do
    patch :update, id: @user_rating, user_rating: { description: @user_rating.description, project_id: @user_rating.project_id, rated_by: @user_rating.rated_by, rating: @user_rating.rating, user_id: @user_rating.user_id }
    assert_redirected_to user_rating_path(assigns(:user_rating))
  end

  test "should destroy user_rating" do
    assert_difference('UserRating.count', -1) do
      delete :destroy, id: @user_rating
    end

    assert_redirected_to user_ratings_path
  end
end
