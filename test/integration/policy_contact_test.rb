require "test_helper"

class PolicyContactTest < ActionDispatch::IntegrationTest
  def teardown
    logout
  end

  def contact_user
    users(:contact_user)
  end
  
  def contact_business
    businesses(:contact_business)
  end
  
  def contact_one
    contacts(:contact_one)
  end
  
  def login_user
    users(:login_user)
  end
  
  test "guest can not see contact index" do
    visit business_contacts_path(contact_business)
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."
  end
  
  test "guest can not see contact show" do
    visit business_contact_path(contact_business, contact_one)
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."    
  end
  
  test "guest can not see contact edit" do
    visit edit_business_contact_path(contact_business, contact_one)
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."    
  end 
  
  test "guest can not create contact" do
    visit new_business_contact_path(contact_business)
    click_button "Create contact"
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."    
  end  
end
