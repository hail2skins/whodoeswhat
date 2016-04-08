require "test_helper"

class UpdateContactsTest < ActionDispatch::IntegrationTest
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
  
  test "edit an existing contact from index" do
    visit business_contacts_path(contact_business)
    within(".table") do
      first(:link, "Edit").click
    end
    
    assert_equal edit_business_contact_path(contact_business, contact_one), current_path
    assert_title "Edit Contact"
    check_content "Edit Contact"
    fill_in "First name", with: "Gone"
    fill_in "Last name", with: "Guy"
    fill_in "Email", with: "gone@guy.com"
    click_button "Update contact"
    
    assert_equal business_contact_path(contact_business, contact_one), current_path
    check_content "Contact has been updated.",
                  "Gone",
                  "Guy",
                  "gone@guy.com"
  end
  
  test "edit from show page" do
    visit business_contact_path(contact_business, contact_one)
    click_link "Edit Contact"
    
    assert_equal edit_business_contact_path(contact_business, contact_one), current_path
  end
    
end
