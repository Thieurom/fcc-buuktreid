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
    # Make a book available for trading
    @book = @user.books.first
    patch trade_open_book_path(@book)
    @book.reload
    assert_equal @book.trading, true
    # Cancel trading for a book
    patch trade_cancel_book_path(@book)
    @book.reload
    assert_equal @book.trading, false
  end
end
