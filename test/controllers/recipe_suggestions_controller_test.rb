require "test_helper"

class RecipeSuggestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipe_suggestions_index_url
    assert_response :success
  end
end
