require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { title: "New Book", author: "Author" } }
    end
    assert_redirected_to books_path
  end

  test "should update book" do
    book = books(:one)
    patch book_url(book), params: { book: { title: "Updated Title" } }
    assert_redirected_to books_path
  end

  test "should destroy book" do
    book = books(:one)
    assert_difference('Book.count', -1) do
      delete book_url(book)
    end
    assert_redirected_to books_path
  end
end
