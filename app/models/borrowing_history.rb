class BorrowingHistory < ApplicationRecord
  belongs_to :book
  validates :borrower_name, presence: true
end
