require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get recipes_search_url
    assert_response :success
  end

  test "should get search_results" do
    get recipes_search_results_url
    assert_response :success
  end
end
