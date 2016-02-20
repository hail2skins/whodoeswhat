require "test_helper"

class SigningUpTest < ActionDispatch::IntegrationTest

  test "when providing valid details" do
    visit "/"
    check_content "Who Does What Landing",
                  "If you want to come in you have to sign in or sign up."
    first(:link, "Sign up").click
  
    fill_in "Email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
  
    assert_equal user_path(User.find_by(email: "test@example.com")), current_path
    check_content "Welcome! You have signed up successfully."
  end
end