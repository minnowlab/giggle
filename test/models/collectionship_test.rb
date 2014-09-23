require 'test_helper'

class CollectionshipTest < ActiveSupport::TestCase
  def setup
    @collectionship = collectionships(:christelle_iphone)
  end

  test "should not save collectionship without user_id" do
    @collectionship.user_id = nil
    assert_not @collectionship.save
  end

  test "should not save collectionship without product_id" do
    @collectionship.product_id = nil
    assert_not @collectionship.save
  end
end
