require 'test_helper'

class TagPolicyTest < PolicyAssertions::Test
  
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

  def test_scope
  end

  def test_show
    refute_permit nil, tag_one
    refute_permit login_user, tag_one
    assert_permit tag_user, tag_one
  end

  def test_create
  end

  def test_update
  end

  def test_destroy
  end
end
