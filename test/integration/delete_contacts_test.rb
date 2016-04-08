require "test_helper"

class DeleteContactsTest < ActionDispatch::IntegrationTest
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
  
  test "delete contact from index" do
    visit business_contacts_path(contact_business)
    within(".table") do
      first(:link, "Delete").click
    end
    
    assert_equal business_contacts_path(contact_business), current_path
    check_content "Contact has been deleted."
    
  end
end
