require 'test_helper'

class PlayHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get play_history_index_url
    assert_response :success
  end

  test "should get create" do
    get play_history_create_url
    assert_response :success
  end

end
