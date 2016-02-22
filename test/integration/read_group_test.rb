require 'test_helper'

class ReadGroupTest < ActionDispatch::IntegrationTest
  def setup
    login_as(group_user)
    visit "/"
  end
  
  def teardown
    click_link "Sign out"
  end

  def group_user
    users(:group_user)
  end
  
  def group_business
    businesses(:group_business)
  end
  
  def group_one
    groups(:group_one)
  end
  
  test "view a group linked to a user and business" do
    check_content "#{group_business.name} Admin",
                  "#{group_business.name}"
    check_links "#{group_business.name} Admin",
                "#{group_business.name}"
    click_link "#{group_business.name} Admin"
    
    assert_equal business_group_path(group_business, group_one), current_path
    assert_title group_one.name
    
  end
  
end