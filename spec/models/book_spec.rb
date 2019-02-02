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

    it '.by_page_count' do
      expect(Book.by_page_count('desc')).to eq [@book_1, @book_2]
      expect(Book.by_page_count('asc')).to eq [@book_2, @book_1]
    end

    it '.by_year' do
      expect(Book.by_year('asc')).to eq [@book_2, @book_1]
      expect(Book.by_year('desc')).to eq [@book_1, @book_2]
    end

    it '.by_rating' do
      tim = User.create(name: "Tim")
      review_1 = Review.create(title: "Total ripoff",
                  rating: 2,
                  review_text: "Worst thing ive read this afternoon",
                  book: @book_1,
                  user: tim
                )

      review_2 = Review.create(title: "Amazing",
                  rating: 4,
                  review_text: "I take it all back, the clown is pure evil.",
                  book: @book_1,
                  user: tim
                )

      expect(Book.by_rating("asc")).to eq([@book_2, @book_1])
      expect(Book.by_rating("desc")).to eq([@book_1, @book_2])
    end

  end

  describe 'instance methods' do

    it '.average_rating' do
      stephen_king = Author.create(name: "Stephen King")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king])
      tim = User.create(name: "Tim")
      review_1 = Review.create(title: "Total ripoff",
                  rating: 2,
                  review_text: "Worst thing ive read this afternoon",
                  book: book_1,
                  user: tim
                )

      review_2 = Review.create(title: "Amazing",
                  rating: 4,
                  review_text: "I take it all back, the clown is pure evil.",
                  book: book_1,
                  user: tim
                )

      expect(book_1.average_rating).to eq(3)

    end
  end
end
