require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "should not save book without title" do
    book = Book.new(author: "Author")
    assert_not book.save, "Saved the book without a title"
  end

  test "should save book with title and author" do
    book = Book.new(title: "New Book", author: "Author")
    assert book.save, "Couldn't save the book with title and author"
  end
end
