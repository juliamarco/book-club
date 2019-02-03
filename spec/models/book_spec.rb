require 'rails_helper'
require 'date'

RSpec.describe Book do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :authors}

    it {should validate_numericality_of(:year)
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(Date.today.year)
      .only_integer
    }
    it {should validate_numericality_of(:page_count)
      .is_greater_than_or_equal_to(0)
      .only_integer
    }
    it {should validate_length_of(:title)
      .is_at_least(1)
    }
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
      @book_3 = Book.create(title: "The Colorado Kid", page_count: 404, year: 1999, authors: [@stephen_king])
      @book_4 = Book.create(title: "Carrie", page_count: 905, year: 1985, authors: [@stephen_king])
    end

    it '.by_page_count' do
      expect(Book.by_page_count('desc')).to eq [@book_1, @book_4, @book_2, @book_3]
      expect(Book.by_page_count('asc')).to eq [@book_3, @book_2, @book_4, @book_1]
    end

    it '.by_year' do
      expect(Book.by_year('asc')).to eq [@book_2, @book_4, @book_1, @book_3]
      expect(Book.by_year('desc')).to eq [@book_3, @book_1, @book_4, @book_2]
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

      expect(Book.by_rating("asc")).to eq([@book_2, @book_3, @book_4, @book_1])
      expect(Book.by_rating("desc")).to eq([@book_1, @book_2, @book_3, @book_4])
    end

    describe 'listing partials in order of review' do
      before :each do
        @user_1 = User.create(name: "ilovereading")
        @user_2 = User.create(name: "tomas_1999")
        @user_3 = User.create(name: "diego_marco")
        @user_4 = User.create(name: "joaquin_meteme")
        @review_1 = @book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: @user_1.id)
        @review_2 = @book_3.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: @user_2.id)
        @review_3 = @book_4.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: @user_3.id)
        @review_4 = @book_3.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: @user_4.id)
        @review_5 = @book_1.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: @user_1.id)
        @review_6 = @book_2.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: @user_1.id)
        @review_7 = @book_2.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: @user_3.id)
        # Book_1 : 2.5, Book_2 : 1.5, Book_3 : 4.5, Book_4 : 5
        # User_1 : 3, User_2 : 1, User_3 : 2, User_4 : 1
      end

      it '.top_books' do
        expect(Book.top_books).to eq([@book_4, @book_3, @book_1])
      end

      it '.worst_books' do
        expect(Book.worst_books).to eq([@book_2, @book_1, @book_3])
      end

    end
  end

  describe 'instance methods' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king])
      @tim = User.create(name: "Tim")
      @review_1 = Review.create(title: "Total ripoff",
        rating: 2,
        review_text: "Worst thing ive read this afternoon",
        book: @book_1,
        user: @tim
      )

      @review_2 = Review.create(title: "Amazing",
        rating: 4,
        review_text: "I take it all back, the clown is pure evil.",
        book: @book_1,
        user: @tim
      )
    end

    it '.average_rating' do
      expect(@book_1.average_rating).to eq(3)
    end

    it '.review_count' do
      expect(@book_1).review_count.to eq(2)
    end
  end
end
