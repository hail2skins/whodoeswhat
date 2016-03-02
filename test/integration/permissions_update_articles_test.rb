require "test_helper"

class PermissionsUpdateArticlesTest < ActionDispatch::IntegrationTest
  def article_business
    businesses(:article_business)
  end
  
  def article_one
    articles(:article_one)
  end
  
  test "fail to edit article as a visitor" do
    visit edit_business_article_path(article_business, article_one)
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."
  end
  
  test "fail to edit article as a user not in the right group" do
    login_as users(:login_user)
    visit edit_business_article_path(article_business, article_one)
    assert_equal user_path(users(:login_user)), current_path
    check_content "You aren't allowed to do that."
    logout
  end
end
