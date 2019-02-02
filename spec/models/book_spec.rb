require 'rails_helper'
require 'date'

RSpec.describe Book do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :authors}

    it {should validate_numericality_of(:year).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(Date.today.year).only_integer}
    it {should validate_numericality_of(:page_count).is_greater_than_or_equal_to(0).only_integer}
    it {should validate_length_of(:title).is_at_least(1)}
  end

  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many :reviews}
  end

  describe 'class methods' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville])
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king, @herman_melville])
    end

    it '.by_page_count' do
      expect(Book.by_page_count('desc')).to eq [@book_1, @book_2]
      expect(Book.by_page_count('asc')).to eq [@book_2, @book_1]
    end

    it '.by_year' do
      expect(Book.by_year('asc')).to eq [@book_2, @book_1]
      expect(Book.by_year('desc')).to eq [@book_1, @book_2]
    end
  end

  describe 'instance methods' do
  end
end
