require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:iPhone)
  end

  test "should not save product without name" do
    @product.name = nil
    assert_not @product.save
  end

  test "should not save product without product category" do
    @product.product_category = nil
    assert_not @product.save
  end

  test "should find product by name" do
    assert_equal Product.search(email: @product.name), [@product]
  end

  test "should find product by min price" do
    assert_equal Product.search(min_price: 3), [@product]
  end

  test "should find product by max price" do
    assert_equal Product.search(max_price: 12), [@product]
  end

  test "should find product by product category id" do
    assert_equal Product.search(product_category_id: @product.product_category_id), [@product]
  end

  test "should classify product by product category id" do
    assert_equal Product.classify_published(product_category_id: @product.product_category_id), [@product]
  end
end
