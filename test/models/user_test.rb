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

  test "should remember_token equal the array join" do
    assert_equal @user.remember_token, [@user.id, Digest::SHA512.hexdigest(@user.password_digest)].join('$')
  end

  test "should find user by remember token" do
    assert_equal User.find_by_remember_token(@user.remember_token), @user
  end

  test "should not find user by wrong remember token" do
    assert_nil User.find_by_remember_token("#{@user.id}$62e5fd56918d7f7b9f23357385d73e27ec094a82")
  end

  test "roles should set by array" do
    @user.roles = ["#{User::ROLES[1]}"]
    assert_equal @user.roles, ["#{User::ROLES[1]}"]
  end

  test "roles should equal USER::ROLES array" do
    assert_equal @user.roles, ["#{User::ROLES[0]}"]
  end

  test "roles should get chinese array" do
    assert_equal @user.roles_cn, User::ROLES_CN[0]
  end

  test "roles should equal admin" do
    assert @user.is?(User::ROLES[0])
  end

  test "roles should not equal manager?" do
    assert_not @user.is?(User::ROLES[1])
  end

  test "should find user by email address" do
    assert_equal User.search(email: @user.email), [@user]
  end

  test "should find user by name" do
    assert_equal User.search(name: @user.name), [@user]
  end

  test "should find user by email address and name" do
    assert_equal User.search(email: @user.email, name: @user.name), [@user]
  end
end
