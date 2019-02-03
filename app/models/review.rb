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

  def self.top_reviews
    order(rating: :desc).limit(3)
  end

  def self.bottom_reviews
    order(rating: :asc).limit(3)
  end

  def self.average_rating
    average(:rating).to_f.round(1)
  end

  def self.by_id(order)
    case order
    when 'desc' then order(id: :desc)
    else order(id: :asc)
    end
  end

end
