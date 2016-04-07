require "test_helper"

class DeleteArticlesTest < ActionDispatch::IntegrationTest
  def setup
    login_as(article_user)
  end
  
  def teardown
    logout
  end
  
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
  
  def contact_user
    users(:contact_user)
  end
  
  def contact_business
    businesses(:contact_business)
  end
  
  def contact_article_one
    articles(:contact_article_one)
  end
  
  def attachment_user
    users(:attachment_user)
  end
  
  def attachment_business
    businesses(:attachment_business)
  end
  
  def attachment_article
    articles(:attachment_article)
  end

  test "delete an article from articles index" do
    visit business_articles_path(article_business)
    first(:link, "Delete").click
    
    assert_equal business_articles_path(article_business), current_path
    check_content "Article has been deleted."
    refute_content "First Article"
  end
  
  test "delete an article from article show page" do
    visit business_article_path(article_business, article_one)
    click_link "Delete"
    
    assert_equal business_articles_path(article_business), current_path
    check_content "Article has been deleted."
    refute_content "First Article"
   end
   
  test "delete an article with an associated contact" do
    logout
    login_as(contact_user)
    visit business_article_path(contact_business, contact_article_one)
    click_link "Delete"
    
    check_content "Article has been deleted."
    refute_content contact_article_one.name
  end
  
  test "delete an article with an associated attachment" do
    logout
    login_as(attachment_user)
    visit business_article_path(attachment_business, attachment_article)
    click_link "Delete"
    
    check_content "Article has been deleted."
    refute_content attachment_article.name
  end  
   
end
