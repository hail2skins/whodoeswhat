require "test_helper"

class ReadContactsTest < ActionDispatch::IntegrationTest

  def setup
    login_as(contact_user)
  end
  
  def teardown
    logout
  end
  
  def contact_user
    users(:contact_user)
  end
  
  def contact_business
    businesses(:contact_business)
  end
  
  def contact_article_one
    articles(:contact_article_one)
  end
  
  def contact_article_two
    articles(:contact_article_two)
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
  
  
  test "confirm you can view multiple contacts to an article with multiple contacts" do
    visit business_article_path(contact_business, contact_article_one)
    check_content "#{contact_one.name}, #{contact_one.email}",
                  "#{contact_two.name}, #{contact_two.email}"
    check_links contact_one.email,
                contact_two.email
  end

  test "confirm you see single contact on an article with a single contact" do
    visit business_article_path(contact_business, contact_article_two)
    check_content "#{contact_three.name}, #{contact_three.email}"
    check_links contact_three.email
  end
  
  test "confirm you can see all contacts on an index page" do
    click_link "Contacts - #{contact_business.name}"
    
    assert_equal business_contacts_path(contact_business), current_path
    
    
  end
  
  test "confirm when you view a contact all associated tickets show for him" do
  
  end


end
