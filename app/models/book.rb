class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :year
  validates_presence_of :page_count
  validates_presence_of :authors

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
      when 'desc' then order(page_count: :desc)
      else order(page_count: :asc)
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
  end

  def average_rating
    reviews.average(:rating)
  end

end
