require 'rails_helper'

RSpec.describe BookAuthor, type: :model do
  describe 'validations' do
    it {should validate_presence_of :book_id}
    it {should validate_presence_of :author_id}
  end

  describe 'relationships' do
    it {should belong_to :author}
    it {should belong_to :book}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
