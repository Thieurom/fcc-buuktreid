require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "page title helper" do
    assert_equal page_title, "Buuktreid | A friendly marketplace for book lovers."
    assert_equal page_title("Sign up for Buuktreid"), "Sign up for Buuktreid" 
  end

end
