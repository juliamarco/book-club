require 'rails_helper'

RSpec.describe Book do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :authors}
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

    it '.by_page_count_ascending' do
      expect(Book.by_page_count_ascending).to eq [@book_2, @book_1]
    end

    it '.by_page_count_descending' do
      expect(Book.by_page_count_descending).to eq [@book_1, @book_2]
    end

    it '.by_year_ascending' do
      expect(Book.by_year_ascending).to eq [@book_2, @book_1]
    end

    it '.by_year_descending' do
      expect(Book.by_year_descending).to eq [@book_1, @book_2]
    end
  end

  describe 'instance methods' do
  end
end
