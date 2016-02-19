require 'test_helper'

class SigningOutTest < ActionDispatch::IntegrationTest

  def setup
    login_as(login_user)
  end
  
  def login_user
    users(:login_user)
  end
  
  test "signed-in users can sign out" do
    visit "/"
    click_link "Sign out"
    check_content "Signed out successfully."
  end
  
end