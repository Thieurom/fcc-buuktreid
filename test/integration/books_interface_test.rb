require 'test_helper'

class BooksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
  end

  test "book interface" do
    log_in_as(@user)
    get new_book_path
    # Add a valid book
    assert_difference 'Book.count', 1 do
      post books_path, params: { book: { title: "Lorem Ipsum", author: "Dolor" } }
    end
  end
end
