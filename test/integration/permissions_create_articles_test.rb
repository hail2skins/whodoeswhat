require "test_helper"

class PermissionsCreateArticlesTest < ActionDispatch::IntegrationTest

  def article_business
    businesses(:article_business)
  end

  test "fail to create article as visitor" do
    visit new_business_article_path(article_business, Article.new)
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."
  end
  
  test "fail to create article as user not in business group" do
    login_as users(:login_user)
    visit new_business_article_path(article_business, Article.new)
    assert_equal user_path(users(:login_user)), current_path
    check_content "You aren't allowed to do that."
    logout
  end


end
