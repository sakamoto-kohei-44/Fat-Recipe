require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get goal" do
    get users_goal_url
    assert_response :success
  end

  test "should get gender_age" do
    get users_gender_age_url
    assert_response :success
  end

  test "should get height_weight_target_weight" do
    get users_height_weight_target_weight_url
    assert_response :success
  end

  test "should get activity_level" do
    get users_activity_level_url
    assert_response :success
  end

  test "should get allergies" do
    get users_allergies_url
    assert_response :success
  end

  test "should get edit_profile" do
    get users_edit_profile_url
    assert_response :success
  end

  test "should get update_profile" do
    get users_update_profile_url
    assert_response :success
  end

  test "should get edit_account" do
    get users_edit_account_url
    assert_response :success
  end

  test "should get update_account" do
    get users_update_account_url
    assert_response :success
  end
end
