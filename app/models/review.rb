class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :rating

  belongs_to :book
  belongs_to :user
end
