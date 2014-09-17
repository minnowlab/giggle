require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages(:leave_message)
  end

  test "should not save message without content" do
    @message.content = nil
    assert_not @message.save
  end
end
