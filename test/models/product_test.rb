require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:iPhone)
  end

  test "should not save product without name" do
    @product.name = nil
    assert_not @product.save
  end
end
