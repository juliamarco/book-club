require 'rails_helper'

RSpec.describe Book do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :page_count}
  end

  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many :authors}
    xit {should have_many :reviews}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
