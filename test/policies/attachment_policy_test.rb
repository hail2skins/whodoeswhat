require 'test_helper'

class AttachmentPolicyTest < PolicyAssertions::Test

  def login_user
    users(:login_user)
  end
  
  def attachment_one
    attachments(:attachment_one)
  end

  def attachment_user
    users(:attachment_user)
  end

  def test_scope
  end

  def test_show
    refute_permit nil, attachment_one
    refute_permit login_user, attachment_one
    assert_permit attachment_user, attachment_one
  end

  def test_create
  end

  def test_update
  end

  def test_destroy
  end
end
