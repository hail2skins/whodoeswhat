require 'test_helper'

class ArticlePolicyTest < PolicyAssertions::Test

  def article_one
    articles(:article_one)
  end
  
  def article_user
    users(:article_user)
  end
  
  def login_user
    users(:login_user)
  end
  
  def article_business
    businesses(:article_business)
  end

#  def test_scope
#  end

  def test_show
    refute_permit nil, article_one
    refute_permit login_user, article_one
    assert_permit article_user, article_one
  end

  def test_create
    refute_permit nil, article_one
    refute_permit login_user, article_one
    assert_permit article_user, article_one
  end

  def test_update
    refute_permit nil, article_one
    refute_permit login_user, article_one
    assert_permit article_user, article_one
  end

  def test_destroy
    refute_permit nil, article_one
    refute_permit login_user, article_one
    assert_permit article_user, article_one
  end
  
  def test_index
    refute_permit nil, article_business.articles
    refute_permit login_user, article_business.articles
    assert_permit article_user, article_business.articles
  end
  
end
