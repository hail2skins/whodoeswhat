require "test_helper"

class ReadArticlesTest < ActionDispatch::IntegrationTest
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


test "show an article from article index" do
  visit "/"
  click_link "KB - #{article_business.name}"

  check_links article_one.name,
             article_two.name
  click_link article_one.name
  
  assert_equal business_article_path(article_business, article_one), current_path
  assert_title "#{article_one.name}"
  check_content article_one.name,
                article_one.content
  check_links "Back to article index",
              "Back to main page",
              "Create new article"
end

test "check all links" do
  visit business_article_path(article_business, article_one)
  click_link "Back to article index"
  
  assert_equal business_articles_path(article_business), current_path
  visit business_article_path(article_business, article_one)
  click_link "Back to main page"
  
  assert_equal user_path(article_user), current_path
  visit business_article_path(article_business, article_one)
  click_link "Create new article"
  
  assert_equal new_business_article_path(article_business, Article.new), current_path

end


end
