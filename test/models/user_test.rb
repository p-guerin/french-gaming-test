require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Testeur", email: "test@test.fr", password: "footest", password_confirmation: "footest")
  end

  test "user_valid" do
    assert @user.valid?
  end

  test "username_presence" do
    @user.username = nil
    assert_not @user.valid?
  end

  test "email_presence" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "username_trop_long" do
    @user.username = "a" * 31
    assert_not @user.valid?
  end

  test "email_trop_long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email_valid" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email_invalid" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email_minuscule" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "email_unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password_presence" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "password_trop_court" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end
end
