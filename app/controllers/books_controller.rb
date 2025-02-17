class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy, :borrow, :return]
  
    # List all books
    def index
      @books = Book.all
      if params[:borrower_name].present?
        @borrowing_histories = BorrowingHistory.where("borrower_name LIKE ?", "%#{params[:borrower_name]}%")
      else
        @borrowing_histories = BorrowingHistory.all
      end
    end
        
  
  
    # Show a single book (with borrowing info)
    def show
      @book = Book.find(params[:id])  
    
      @borrowing_histories = @book.borrowing_histories
    end
  
    # Create a new book
    def new
      @book = Book.new
    end
  
    def create
        @book = Book.new(book_params)
      
        if @book.save
          redirect_to books_path, notice: "Book added successfully!" # Redirect to book list
        else
          render :new, status: :unprocessable_entity # Stay on the form if validation fails
        end
      end
      
  
    # Edit an existing book
    def edit
    end
  
    def update
      if @book.update(book_params)
        redirect_to books_path, notice: "Book was successfully updated."
      else
        render :edit
      end
    end
  
    # Delete a book
    def destroy
      @book.destroy
      redirect_to books_path, notice: "Book deleted successfully."
    end

  
    def borrow
      if @book.available? # Check if the book is available for borrowing
        # Create borrowing history and update the book's status
        BorrowingHistory.create(book: @book, borrower_name: params[:borrower_name], borrowed_at: Time.now)
        redirect_to @book, notice: "Book borrowed successfully!"
      else
        redirect_to @book, alert: "This book is already borrowed."
      end
    end
  
    # Return a book
    def return
      if !@book.available? # Check if the book is borrowed
        # Update the borrowing history with the return date
        last_borrowing_history = @book.borrowing_histories.where(returned_at: nil).last
        last_borrowing_history.update(returned_at: Time.now)
        
        redirect_to @book, notice: "Book returned successfully!"
      else
        redirect_to @book, alert: "This book is not currently borrowed."
      end
    end
    def borrowing_history
      @borrower_name = params[:borrower_name]
      @borrowing_histories = BorrowingHistory.where(borrower_name: @borrower_name)
    
      render "borrowing_history"
    end
    
    private
  
    def set_book
      @book = Book.find(params[:id])
    end
  end
    private
  
    private

    def set_book
      @book = Book.find_by(id: params[:id])
      unless @book
        redirect_to books_path, alert: "Book not found."
      end
    end

  
    def book_params
      params.require(:book).permit(:title, :author)
    end
  
  