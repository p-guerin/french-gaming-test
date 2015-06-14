require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "invalid_login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, login: { user: nil, password: nil }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "valid_login" do
    get login_path
    post login_path, login: { user: @user.email, password: 'password' }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'home/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "valid_login_and_logout" do
    get login_path
    post login_path, login: { user: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'home/index'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    get logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    get logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login_with_remember" do
    log_in_as(@user, remember: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login_without_remember" do
    log_in_as(@user, remember: '0')
    assert_nil cookies['remember_token']
  end
end
