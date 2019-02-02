class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {minimum: 1}

  has_many :reviews
end
