require 'test_helper'

class UsersEditProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
  end

  test "unsuccessful edit profile" do
    log_in_as(@user)
    get edit_profile_user_url(@user)
    assert_template 'users/edit_profile'
    patch edit_profile_user_path(@user), params: { user: { username: "",
                                                           email: "user@invalid" } }
    assert_template 'users/edit_profile'
  end

  test "successful edit profile with friendly forwarding" do
    get edit_profile_user_url(@user)
    log_in_as(@user)
    assert_redirected_to edit_profile_user_url(@user)
    username = "foo_bar"
    email = "foo@bar.com"
    patch edit_profile_user_path(@user), params: { user: { username: "foo_bar",
                                                           email: "foo@bar.com"} }
    assert_redirected_to @user
    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
  end
end
