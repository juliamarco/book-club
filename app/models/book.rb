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

  def average_rating
    reviews.average(:rating)
  end

end
