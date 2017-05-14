require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
    @other_user = users(:other)
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should redirect edit profile when not logged in" do
    get edit_profile_user_url(@user)
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch edit_profile_user_url(@user), params: { user: { username: @user.username,
                                                          email: @user.email } }
    assert_redirected_to login_url
  end

  test "should redirect edit profile when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_profile_user_url(@user)
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch edit_profile_user_url(@user), params: { user: { username: @user.username,
                                                          email: @user.email } }
    assert_redirected_to root_url
  end

end
