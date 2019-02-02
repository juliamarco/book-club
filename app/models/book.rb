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
    when 'desc' then order(page_count: :desc)
      else order(page_count: :asc)
    end
  end

end
