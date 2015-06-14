require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "edit_redirect_login_not_logged" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "update_redirect_not_logged" do
    patch :update, id: @user, user: { username: @user.username, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "edit_redirect_login_wrong_user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "update_redirect_login_wrong_user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { username: @user.username, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "redirect_index_not_logged" do
    get :index
    assert_redirected_to login_url
  end

  test "destroy_redirect_not_logged" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "destroy_redirect_non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
end
