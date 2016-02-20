require 'test_helper'

class SigningInTest < ActionDispatch::IntegrationTest

  def teardown
    click_link "Sign out"
  end

  def login_user
    users(:login_user)
  end
  
  test "with valid credentials" do
    visit "/"
    first(:link, "Sign in").click
    
    fill_in "Email", with: login_user.email
    fill_in "Password", with: "password"
    click_button "Sign in"
    
    check_content "Signed in successfully.",
                  "Signed in as #{login_user.email}"
  end
  
end