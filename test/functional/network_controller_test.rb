require 'test_helper'

class NetworkControllerTest < ActionController::TestCase
  test "should get sylab" do
    get :sylab
    assert_response :success
  end

end
