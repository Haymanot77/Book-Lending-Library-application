class BorrowingHistoriesController < ApplicationController
    def index
      @borrowers = BorrowingHistory.select(:borrower_name).distinct
      if params[:borrower_name].present?
        @borrowing_histories = BorrowingHistory.where("borrower_name LIKE ?", "%#{params[:borrower_name]}%")
      else
        @borrowing_histories = BorrowingHistory.all
      end
    end

    def show
      @borrower_name = params[:id]
      @histories = BorrowingHistory.where(borrower_name: @borrower_name).order(borrowed_at: :desc)
    end
end

