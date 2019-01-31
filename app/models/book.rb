class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :year
  validates_presence_of :page_count
  validates_presence_of :authors

  has_many :book_authors
  has_many :reviews
  has_many :authors, through: :book_authors
end
