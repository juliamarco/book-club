class Author < ApplicationRecord
  validates :name, presence: true, length: {minimum: 1}
  has_many :book_authors
  has_many :books, through: :book_authors, dependent: :destroy
end
