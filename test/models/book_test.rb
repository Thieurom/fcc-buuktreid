require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup
    @user = users(:lethieu)
    @book = @user.books.build(title: "Steve Jobs", author: "Walter Issacson")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end

  test "title should be present" do
    @book.title = "     "
    assert_not @book.valid?
  end

  test "author should be present" do
    @book.author = "     "
    assert_not @book.valid?
  end

  test "order should be most recent updated first" do
    assert_equal books(:most_recent_updated), Book.first
  end
end
