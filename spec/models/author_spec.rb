require 'rails_helper'

RSpec.describe Author do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_length_of(:name)
      .is_at_least(1)
    }
  end


  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:books).through(:book_authors)}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
