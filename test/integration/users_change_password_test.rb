require 'test_helper'

class UsersChangePasswordTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
  end

  test "unsuccessful change password" do
    log_in_as(@user)
    # Wrong current password
    get change_password_user_url(@user)
    assert_template 'password_change/new'
    post change_password_user_url(@user), params: { password: { current_password: "",
                                                           password: "newpassword" } }
    assert_template 'password_change/new'
    assert_not flash.empty?

    # Empty new password
    post change_password_user_url(@user), params: { password: { current_password: "password",
                                                           password: "" } }
    assert_not flash.empty?

    # Invalid new password
    post change_password_user_url(@user), params: { password: { current_password: "password",
                                                           password: "pass" } }
    assert_select 'div.alert-info'
  end

  test "successful change password" do
    get change_password_user_url(@user)
    log_in_as(@user)
    assert_redirected_to change_password_user_url(@user)
    new_password = "foo_bar"
    post change_password_user_url(@user), params: { password: { current_password: "password",
                                                           password: new_password} }
    assert_redirected_to login_url
    post login_path, params: { session: { username: @user.username, password: new_password} }
    assert_redirected_to root_url
  end
end
