require "test_helper"

class PolicyTagsTest < ActionDispatch::IntegrationTest
  def teardown
    logout
  end
  
  def tag_user
    users(:tag_user)
  end
  
  def tag_business
    businesses(:tag_business)
  end
  
  def tag_one
    tags(:tag_one)
  end
  
  def login_user
    users(:login_user)
  end
  
  test "guest can not see tag show" do
    visit business_tag_path(tag_business, tag_one.name)
    assert_equal root_path, current_path
    check_content "You aren't allowed to do that."
  end
  

end
