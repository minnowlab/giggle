require 'test_helper'

class ProductCategoryTest < ActiveSupport::TestCase
  def setup
    @product_category = product_categories(:cell_phones)
  end

  test "should not save product category without name" do
    @product_category.name = nil
    assert_not @product_category.save
  end
end
