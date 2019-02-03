class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {minimum: 1}

  has_many :reviews

  def self.top_reviewers(count)
    select("users.*, COUNT(reviews.id) as num_reviews")
    .joins(:reviews)
    .group(:id)
    .order("num_reviews DESC")
    .order(id: :asc)
    .limit(count)
  end
end
