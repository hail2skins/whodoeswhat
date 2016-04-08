require "test_helper"

class CreateContactsTest < ActionDispatch::IntegrationTest
  def setup
    login_as(contact_user)
  end
  
  def teardown
    logout
  end
  
  def contact_user
    users(:contact_user)
  end
  
  def contact_one
    contacts(:contact_one)
  end
  
  def contact_two
    contacts(:contact_two)
  end
  
  def contact_three
    contacts(:contact_three)
  end
  
  def contact_business
    businesses(:contact_business)
  end

  test "create a contact from outside an article" do
    visit business_contacts_path(contact_business)
    check_links "New Contact"
    click_link "New Contact"
    
    assert_equal new_business_contact_path(contact_business), current_path
    assert_title "Create Contact"
    check_content "New Contact"
    check_links "Back"
    fill_in "First name", with: "Dan"
    fill_in "Last name", with: "Dutton"
    fill_in "Email", with: "dan@test.com"
    click_button "Create contact"
    
    assert_equal business_contact_path(contact_business, Contact.last), current_path
    check_content "Contact created."
  end
  
  test "fail to create a contact with the same email" do
    visit new_business_contact_path(contact_business)
    fill_in "First name", with: "Art"
    fill_in "Last name", with: "Mills"
    fill_in "Email", with: "art@test.com"
    click_button "Create contact"
    
    check_content "has already been taken"
    
  end

end
