require "test_helper"

class ReadTagsTest < ActionDispatch::IntegrationTest

  def setup
    login_as(tag_user)
  end
  
  def teardown
    logout
  end
  
  def tag_user
    users(:tag_user)
  end
  
  def tag_business
    businesses(:tag_business)
  end
  
  def tag_article_one
    articles(:tag_article_one)
  end
  
  def tag_article_two
    articles(:tag_article_two)
  end
  
  def tag_one
    tags(:tag_one)
  end
  
  def tag_two
    tags(:tag_two)
  end

  test "confirm you can view multiple tags to an article with multiple tags" do
    visit business_article_path(tag_business, tag_article_one)
    check_links tag_one.name,
                tag_two.name
    check_content "#{tag_one.name}, #{tag_two.name}"
  end

  test "confirm you see a single tag to an article with a single tag" do
    visit business_article_path(tag_business, tag_article_two)
    check_links tag_one.name
  end
  
  test "confirm you can see tags on article index page" do
    visit business_articles_path(tag_business)
    check_content "Tags",
                  "#{tag_one.name}, #{tag_two.name}",
                  tag_one.name
    check_links tag_one.name,
                tag_two.name
  end
  
  test "clicking a tag link shows you all articles associated with that tag for the business" do
    visit business_article_path(tag_business, tag_article_one)
    click_link tag_one.name
    
    assert_equal business_tag_path(tag_business, tag_one.name), current_path
    assert_title tag_one.name
    check_content tag_one.name,
                  tag_article_one.name,
                  tag_article_two.name
    check_links tag_article_one.name,
                tag_article_two.name
  end
end
