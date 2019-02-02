class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :review_text
  validates_presence_of :rating

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

end
