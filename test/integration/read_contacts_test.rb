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
  
  def contact_article_three
    articles(:contact_article_three)
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
    visit root_path
    click_link "Contacts - #{contact_business.name}"
    
    assert_equal business_contacts_path(contact_business), current_path
    assert_title "Contacts - #{contact_business.name}"
    check_content "Contact List"
    check_links "Return to main page"
    within(".table") do
      check_content "First Name",
                    "Last Name",
                    "Email",
                    "Articles Associated",
                    "Art",
                    "Mills",
                    "art@test.com",
                    "Jonathan",
                    "Engstrom",
                    "jonathan@test.com",
                    "Drew",
                    "Pierce",
                    "drew@test.com"
    end
    
    
  end
  
  test "view a specific contact from an article page" do
    visit business_article_path(contact_business, contact_article_one)
    click_link contact_one.email
    
    assert_equal business_contact_path(contact_business, contact_one), current_path
    assert_title "Contact - #{contact_one.name}"
    check_content "Associated Articles",
                  "#{contact_business.name} Contact",
                  "Name: #{contact_one.name}",
                  "Email: #{contact_one.email}",
                  "Associated Article Count: 2"
    check_links "Back to main page"
    within(".table-kb-information") do
      check_content "Name",
                    "Content",
                    "Last touched",
                    contact_article_one.name,
                    contact_article_three.name
    end
  end
  
  test "view a specific contact from the contact index page" do
    visit business_contacts_path(contact_business)
    puts page.body
    click_link contact_one.email
    
    assert_equal business_contact_path(contact_business, contact_one), current_path
  end
  

end
