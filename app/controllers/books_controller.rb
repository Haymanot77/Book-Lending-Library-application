class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy, :borrow, :return]
  
    def index
      @books = Book.all
    end
  
    def show
      @borrowing_histories = @book.borrowing_histories.order(borrowed_at: :desc)
    end
  
    def new
      @book = Book.new
    end
  
    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to books_path, notice: "Book successfully added."
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @book.update(book_params)
        redirect_to books_path, notice: "Book updated successfully."
      else
        render :edit
      end
    end
  
    def destroy
      @book.destroy
      redirect_to books_path, notice: "Book deleted successfully."
    end
  
    def borrow
      @book.update(available: false)
      BorrowingHistory.create(book: @book, borrower_name: params[:borrower_name], borrowed_at: Time.now)
      redirect_to @book, notice: "Book borrowed successfully."
    end
  
    def return
      history = @book.borrowing_histories.where(returned_at: nil).last
      history.update(returned_at: Time.now) if history
      @book.update(available: true)
      redirect_to @book, notice: "Book returned successfully."
    end
  
    private
  
    def set_book
      @book = Book.find(params[:id])
    end
  
    def book_params
      params.require(:book).permit(:title, :author, :description, :available)
    end
  end
  