class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :year
  validates_presence_of :page_count
  validates_presence_of :authors

  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors

  def self.by_page_count_ascending
    order(page_count: :asc)
  end

  def self.by_page_count_descending
    order(page_count: :desc)

  end

  def self.by_year_ascending
    order(year: :asc)
  end

  def self.by_year_descending
    order(year: :desc)
  end
end
