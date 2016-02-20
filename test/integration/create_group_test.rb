require 'test_helper'

class CreateGroupTest < ActionDispatch::IntegrationTest
  def setup
    login_as(login_user)
    visit "/"
  end
  
  def teardown
    click_link "Sign out"
  end

  def login_user
    users(:login_user)
  end
  
  test "test" do
    check_content "You are not associated with any businesses.",
                  "Click here to create an association.",
                  "Group Count: 0"
    check_links "Click here to create an association."
    click_link "Click here to create an association."
    
    assert_equal new_business_path(business), current_path
    
    
  end
end