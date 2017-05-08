require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test 'home links' do
    get root_url
    assert_template 'home/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signup_path

    get signup_url
    assert_template 'users/new'
    assert_select "title", page_title("Sign up for Buuktreid")
  end

end
