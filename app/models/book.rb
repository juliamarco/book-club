require 'date'

class Book < ApplicationRecord
  validates_presence_of :authors

  validates :year, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: Date.today.year,
    only_integer: true
  }

  validates :page_count, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }

  validates :title, presence: true, length: {minimum: 1}

  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  def self.by_page_count(order)
    case order
      when 'desc' then order(page_count: :desc)
      else order(page_count: :asc)
    end
  end

  def self.by_year(order)
    case order
    when 'desc' then order(year: :desc)
    else order(year: :asc)
    end
  end

  def self.by_rating(order)
    case order
      when 'desc' then order_sym = :desc
      else order_sym = :asc
    end

    select("books.*, coalesce(AVG(reviews.rating), 0) AS average_rating")
    .left_outer_joins(:reviews)
    .group(:id)
    .order("average_rating #{order_sym}")
    .order(:id)
  end

  def self.top_books
    by_rating("desc").limit(3)
  end

  def self.worst_books
    by_rating('asc').limit(3)
  end

  def average_rating
    reviews.average(:rating).to_f
  end

  def review_count
    reviews.count
  end

  def top_review
    reviews.order(rating: :desc).first
  end

end
