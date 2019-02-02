require 'rails_helper'

RSpec.describe Review do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :review_text}

    it {should validate_numericality_of(:rating).is_less_than_or_equal_to(5).is_greater_than_or_equal_to(1).only_integer}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :book}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
