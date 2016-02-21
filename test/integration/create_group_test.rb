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
  
  test "successfully create first group through business association" do
    check_content "You are not associated with any businesses.",
                  "Click here to create an association.",
                  "Group Count: 0"
    check_links "Click here to create an association."
    click_link "Click here to create an association."
    
    assert_equal new_business_path(Business.new), current_path
    assert_title "Create a business"
    check_content "New business"
    check_links "Return to main page"
    find_field "Name"
    fill_in "Name", with: "Test Business"
    click_button "Create business"
    
    assert_equal user_path(login_user), current_path
    refute_content "You are not associated with any businesses.",
                   "Click here to create an association.",
                   "Group Count: 0"
    check_content "Group Count: 1",
                  "Successfully created an association."
    check_links "1",
                "Create new association"
  end
  
  test "successfully create second group through business association" do
    click_link "Click here to create an association."
    
    fill_in "Name", with: "Test Business"
    click_button "Create business"
    
    check_content "Group Count: 1"
    click_link "Create new association"
    
    fill_in "Name", with: "Whatever Business"
    click_button "Create business"
    
    check_content "Group Count: 2"
  end
  
  test "fail to create a group through business association with invalid attributes" do
    click_link "Click here to create an association."
    
    click_button "Create business"
    check_content "Please review the problems below:",
                  "can't be blank"
  end
  
end