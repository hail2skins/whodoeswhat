require "test_helper"

class UpdateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    login_as(article_user)
  end
  
  def teardown
    Capybara.use_default_driver
    logout  end
  
  def article_user
    users(:article_user)
  end
  
  def article_business
    businesses(:article_business)
  end
  
  def article_one
    articles(:article_one)
  end
  
  def article_two
    articles(:article_two)
  end
  
  test "update article from article index" do
    visit business_articles_path(article_business)
    find(:linkhref, edit_business_article_path(article_business, article_one)).click 
    
    assert_equal edit_business_article_path(article_business, article_one), current_path
    assert_title "Edit Knowledge"
    check_content "Edit Knowledge"
    fill_in "Title", with: "New Name Article"
    fill_in "Content", with: "Yep.  I still need 20
                              words and I have to type
                              a lot to get there but
                              I type fast sometimes and
                              I am very cool obviously."
    click_button "Update article"
    
    assert_equal business_article_path(article_business, article_one), current_path
    refute_content article_one.name
    refute_content article_one.content
    check_content "New Name Article",
                  "Yep.  I still need 20
                  words and I have to type
                  a lot to get there but
                  I type fast sometimes and
                  I am very cool obviously.",
                  "Article has been updated."
  end
  
  test "edit article from article show page" do
    visit business_article_path(article_business, article_one)
    click_link "Edit"
    
    assert_equal edit_business_article_path(article_business, article_one), current_path
  end
  
  test "fail to edit article due to invalid fields" do
    visit edit_business_article_path(article_business, article_one)
    fill_in "Title", with: ""
    fill_in "Content", with: ""
    click_button "Update article"
    
    check_content "Article has not been updated",
                  "can't be blank",
                  "your content must be at least 50 characters"
  end
  
  test "update article without attachments with one attachment" do
    logout
    Capybara.current_driver = :poltergeist
    login_as(users(:article_user))
    visit new_business_article_path(article_business)
    fill_in "Title", with: "No attachments"
    fill_in "Content", with: "I want this to work.   
                              I need this to work.   
                              I will make it work.   
                              I demand it to work.
                              Or I shall die."
    click_button "Create article"
    
    click_link "Edit"
    fill_in "Title", with: "Now one attachment"
    click_link "add attachment"
    attach_file "File", Rails.root.join("test/files/spin.txt")
    click_button "Update article"
    
    within(".attachments") do
      check_content "spin.txt"
    end
  end
  
  test "update article without contacts with one contact" do
    visit edit_business_article_path(article_business, article_one)
    
    
  end
  
end
