class BorrowingHistoriesController < ApplicationController
    def index
      @borrowers = BorrowingHistory.select(:borrower_name).distinct
    end

    def show
      @borrower_name = params[:id]
      @histories = BorrowingHistory.where(borrower_name: @borrower_name).order(borrowed_at: :desc)
    end
end
