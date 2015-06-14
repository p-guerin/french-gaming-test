require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid_signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end

  test "valid_signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect signup_path, user: { username: "Example", email: "user@example.com", password: "password", password_confirmation: "password" }
    end
    assert_template 'home/index'
  end

end
