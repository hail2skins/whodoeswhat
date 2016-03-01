require "test_helper"

class PermissionsCreateArticlesTest < ActionDispatch::IntegrationTest

def article_business
  businesses(:article_business)
end

test "fail to access articles index as visitor" do
  visit business_articles_path(article_business)
  assert_equal root_path, current_path
  check_content "You aren't allowed to do that."
end

test "fail to access articles index as user not in a business group" do
  login_as users(:login_user)
  visit business_articles_path(article_business)
  assert_equal user_path(users(:login_user)), current_path
  check_content "You aren't allowed to do that."
  click_link "Sign out"
end


end
