require "test_helper"

class SigningUpTest < ActionDispatch::IntegrationTest

  test "when providing valid details" do
    visit "/"
    click_link "Sign up"
  
    fill_in "Email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
  
    check_content "Welcome! You have signed up successfully."
  end
end