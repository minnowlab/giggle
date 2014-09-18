require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages(:leave_message)
  end

  test "should not save message without content" do
    @message.content = nil
    assert_not @message.save
  end

  test "should not save message the type have not include Product or Evaluate" do
    @message.messageable_type = "User"
    assert_not @message.save
  end

  test "messageable_cn should equal 产品" do
    assert_equal @message.messageable_cn, "产品"
  end

  test "messageable_name should equal product name" do
    assert_equal @message.messageable_name, "Apple iPhone 5s"
  end

  test "should find message by content" do
    assert_equal Message.search(content: "everyone"), [@message]
  end

  test "should find message by product name" do
    assert_equal Message.search(product: "iPhone"), [@message]
  end

  test "should find message by messageable type" do
    assert_equal Message.search(messageable_type: @message.messageable_type), [@message]
  end
end
