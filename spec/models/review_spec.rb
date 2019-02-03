require 'rails_helper'

RSpec.describe Review do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :review_text}

    it {should validate_numericality_of(:rating)
      .is_less_than_or_equal_to(5)
      .is_greater_than_or_equal_to(1)
      #.ignoring_interference_by_writer
    }
    it {should validate_length_of(:title).is_at_least(1)}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :book}
  end

  describe 'class methods' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville])
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king, @herman_melville])
      @user_1 = User.create(name: "ilovereading")
      @user_2 = User.create(name: "tomas_1999")
      @user_3 = User.create(name: "diego_marco")
      @user_4 = User.create(name: "joaquin_meteme")
      @user_5 = User.create(name: "inma_oteros")
      @user_6 = User.create(name: "de_marco_perez")
      @user_7 = User.create(name: "noone")
      @review_1 = @book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: @user_1.id)
      @review_2 = @book_1.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: @user_2.id)
      @review_3 = @book_1.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: @user_3.id)
      @review_4 = @book_1.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: @user_4.id)
      @review_5 = @book_1.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: @user_7.id)
      @review_6 = @book_1.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: @user_5.id)
      @review_7 = @book_1.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: @user_6.id)
      end

    it '.top_reviews' do
      expect(Review.top_reviews).to eq [@review_4, @review_3, @review_2]
    end

    it '.bottom_reviews' do
      expect(Review.bottom_reviews).to eq [@review_6, @review_1, @review_7]
    end

    it '.average_rating' do
      expect(Review.average_rating).to eq 3.1
    end

  end

  describe 'instance methods' do
  end
end
