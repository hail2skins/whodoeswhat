require 'test_helper'

class ContactPolicyTest < PolicyAssertions::Test

  def contact_user
    users(:contact_user)
  end
  
  def contact_business
    businesses(:contact_business)
  end
  
  def contact_one
    contacts(:contact_one)
  end
  
  def login_user
    users(:login_user)
  end
  
  def test_scope
  end

  def test_index
    refute_permit nil, Contact, 'index?'
    refute_permit login_user, Contact, 'index?'
    assert_permit contact_user, Contact, 'index?'
  end

  def test_show
    refute_permit nil, contact_one
    refute_permit login_user, contact_one
    assert_permit contact_user, contact_one
  end
  
  def test_edit
    refute_permit nil, contact_one
    refute_permit login_user, contact_one
    assert_permit contact_user, contact_one
  end

  def test_create
    refute_permit nil, contact_one
    refute_permit login_user, contact_one
    assert_permit contact_user, contact_one   
  end

  def test_update
    refute_permit nil, contact_one
    refute_permit login_user, contact_one
    assert_permit contact_user, contact_one
  end

  def test_destroy
    refute_permit nil, contact_one
    refute_permit login_user, contact_one
    assert_permit contact_user, contact_one
  end
end
