require 'test_helper'

class ArticlePolicyTest < PolicyAssertions::Test

  def test_scope
  end

  def test_show
  end

  def test_create
  end

  def test_update
  end

  def test_destroy
  end
  
  def test_index
    refute_permit nil, Article
  end
end
