class Review < ApplicationRecord
  validates_presence_of :review_text
  validates :rating, presence: true, numericality: {
    integer_only: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }

  validates :title, presence: true, length: {minimum: 1}

  belongs_to :book
  belongs_to :user
end
