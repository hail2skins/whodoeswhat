require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    login_as(login_user)
    visit "/"
  end
  
  def teardown
    click_link "Sign out"
  end
  
  def login_user
    users(:login_user)
  end
  
  def load_business
    Business.find_by(name: "Load First Business")
  end
  
  test "create first article" do
    refute_links "KB - "
    #from load.rb to create business, group and membership
    load_first_group_business
    visit current_path
    check_links "KB - #{load_business.name}"
    click_link "KB - #{load_business.name}"
    
    assert_equal business_articles_path(load_business), current_path
    
    
  end
end
