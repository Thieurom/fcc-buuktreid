require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  test "should redirect search book when not logged in" do
    get new_book_url
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Book.count' do
      post books_path, params: { book: { title: "Lorem ipsum", author: "Dolor" } }
    end
    assert_redirected_to login_url
  end
end
