class Book < ApplicationRecord
    has_many :borrowing_histories,dependent: :destroy
    validates :title, :author, presence: true
  
    def borrowed?
      borrowed_by.present?
    end
    def available?
        !borrowing_histories.exists?(returned_at: nil)
    end
    
    
  end
  