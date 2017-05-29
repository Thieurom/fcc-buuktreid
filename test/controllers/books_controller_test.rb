require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
    @book = books(:one)
  end

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

  test "should redirect open trading when not logged in" do
    patch trade_open_book_path(@book)
    assert_redirected_to login_url
  end

  test "should redirect accept trading when not logged in" do
    patch trade_accept_book_path(@book)
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    delete delete_book_path(@book)
    assert_redirected_to login_url
  end

  test "should redirect open trading for wrong book" do
    log_in_as(@user)
    assert_no_difference 'Book.count' do
      patch trade_open_book_path(@book)
    end
    assert_redirected_to root_url
  end

  test "should redirect cancel trading for wrong book" do
    log_in_as(@user)
    assert_no_difference 'Book.count' do
      patch trade_cancel_book_path(@book)
    end
    assert_redirected_to root_url
  end

  test "should redirect delete for wrong book" do
    log_in_as(@user)
    assert_no_difference 'Book.count' do
      delete delete_book_path(@book)
    end
    assert_redirected_to root_url
  end
end
