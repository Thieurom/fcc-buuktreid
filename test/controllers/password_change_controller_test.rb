require 'test_helper'

class PasswordChangeControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
    @other_user = users(:other)
  end

  test "should redirect change password when not logged in" do
    get change_password_user_url(@user)
    assert_redirected_to login_url
  end

  test "should redirect update change password when not logged in" do
    post change_password_user_url(@user), params: { user: { username: @user.username,
                                                          email: @user.email } }
    assert_redirected_to login_url
  end

  test "should redirect change password when logged in as wrong user" do
    log_in_as(@other_user)
    get change_password_user_url(@user)
    assert_redirected_to root_url
  end

  test "should redirect change password update when logged in as wrong user" do
    log_in_as(@other_user)
    post change_password_user_url(@user), params: { user: { username: @user.username,
                                                          email: @user.email } }
    assert_redirected_to root_url
  end

end
