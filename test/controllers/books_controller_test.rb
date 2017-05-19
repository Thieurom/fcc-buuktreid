require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  test "should redirect search book when not logged in" do
    get new_book_url
    assert_redirected_to login_url
  end
end
