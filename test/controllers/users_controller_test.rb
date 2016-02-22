# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require "test_helper"

class UsersControllerTest < ActionController::TestCase
  
  def setup
    sign_in login_user
  end
  
  def teardown
    sign_out login_user
  end
  
  def login_user
    users(:login_user)
  end
  

  test "should get show" do
    get :show, params: { id: login_user.id }
    assert_response :success
  end

end
