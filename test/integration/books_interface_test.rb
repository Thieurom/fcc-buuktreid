require 'test_helper'

class BooksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
    @other_user = users(:other)
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
    # Accept a trading
    patch trade_open_book_path(@book)
    log_out
    log_in_as(@other_user)
    assert_difference '@other_user.books.count', 1 do
     patch trade_accept_book_path(@book)
    end
    # Delete book
    assert_difference '@other_user.books.count', -1 do
     delete delete_book_path(@book)
    end
  end
end
