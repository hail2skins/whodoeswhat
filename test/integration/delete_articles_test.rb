require "test_helper"

class DeleteArticlesTest < ActionDispatch::IntegrationTest
  def setup
    login_as(article_user)
  end
  
  def teardown
    click_link "Sign out"
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
end
