require "test_helper"

class UsersControllerTest < ActionController::TestCase
  
  def setup
    sign_in login_user
  end
  
  def teardown
    sign_out login_user
  end
  
  def login_user
    users(:login_user)
  end
  

  test "should get show" do
    get :show, id: User.first
    assert_response :success
  end

end
