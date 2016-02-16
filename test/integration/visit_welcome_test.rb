require 'test_helper'
class VisitWelcomeTest < ActionDispatch::IntegrationTest
  test "visit root path" do
    visit root_path
    assert page.has_content?(Time.now), "Time.now not here baby."
  end
end