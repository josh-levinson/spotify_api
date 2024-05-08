require "test_helper"

class SearchArtistControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get search_artist_show_url
    assert_response :success
  end
end
