require "test_helper"

class BusinessTest < ActiveSupport::TestCase

  def business
    @business ||= Business.new
  end

  def test_valid
    assert business.valid?
  end

end
