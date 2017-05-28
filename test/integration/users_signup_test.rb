require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_url
    assert_select 'form[action="/signup"]'

    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "",
                                         email: "user@invalid",
                                         password: "foo" } }
    end

    assert_template 'users/new'
    assert_select 'div.error-alert'
    assert_select 'p.alert'
  end

  test "valid signup information" do
    get signup_url
    assert_select 'form[action="/signup"]'

    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "example_user",
                                         email: "user@example.com",
                                         password: "foobar" } }
    end

    follow_redirect!
    assert_template 'home/index'
    assert is_logged_in?
  end
end
