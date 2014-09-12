require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:christelle)
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should not save user without email" do
    @user.email = nil
    assert_not @user.save
  end

  test "should not save user without name" do
    @user.name = nil
    assert_not @user.save
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "should not save user without password" do
    @user.password = nil
    assert_not @user.save
  end

  test "should not save user password and password_confirmation not the same" do
    @user.password = "123456789"
    @user.password_confirmation = "123456"
    assert_not @user.save
  end
end
