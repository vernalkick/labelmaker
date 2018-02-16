require 'test_helper'

class LabelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get label_index_url
    assert_response :success
  end

end
