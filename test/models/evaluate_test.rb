require 'test_helper'

class EvaluateTest < ActiveSupport::TestCase
  def setup
    @evaluate = evaluates(:product_evaluate)
  end

  test "should not save evaluate without title" do
    @evaluate.title = nil
    assert_not @evaluate.save
  end

  test "should not save evaluate without details" do
    @evaluate.details = nil
    assert_not @evaluate.save
  end

  test "should find evaluate by title" do
    assert_equal Evaluate.search(title: @evaluate.title), [@evaluate]
  end

  test "should find evaluate by product" do
    assert_equal Evaluate.search(product: "iPhone"), [@evaluate]
  end

  test "should find evaluate by user" do
    assert_equal Evaluate.search(user: "christelle"), [@evaluate]
  end
end
