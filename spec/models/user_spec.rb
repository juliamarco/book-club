require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of(:name)}
    it {should validate_length_of(:name)
      .is_at_least 1
    }
  end

  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'class methods' do

    it 'top_reviewers' do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      user_1 = User.create(name: "ilovereading")
      user_2 = User.create(name: "tomas_1999")
      user_3 = User.create(name: "diego_marco")
      user_4 = User.create(name: "joaquin_meteme")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville])
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king, herman_melville])
      book_3 = Book.create(title: "The Colorado Kid", page_count: 702, year: 1984, authors: [stephen_king])
      book_4 = Book.create(title: "Carrie", page_count: 404, year: 1999, authors: [stephen_king])
      review_1 = book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: user_1.id)
      review_2 = book_3.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: user_2.id)
      review_3 = book_4.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: user_3.id)
      review_4 = book_2.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: user_4.id)
      review_5 = book_1.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: user_1.id)
      review_6 = book_2.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: user_1.id)
      review_7 = book_2.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: user_3.id)

      expect(User.top_reviewers(1)).to eq([user_1])
      expect(User.top_reviewers(2)).to eq([user_1, user_3])
      expect(User.top_reviewers(3)).to eq([user_1, user_3, user_2])
    end
  end

  describe 'instance methods' do
    it '.review_count' do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      user_1 = User.create(name: "ilovereading")
      user_2 = User.create(name: "tomas_1999")
      user_3 = User.create(name: "diego_marco")
      user_4 = User.create(name: "joaquin_meteme")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville])
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king, herman_melville])
      book_3 = Book.create(title: "The Colorado Kid", page_count: 702, year: 1984, authors: [stephen_king])
      book_4 = Book.create(title: "Carrie", page_count: 404, year: 1999, authors: [stephen_king])
      review_1 = book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: user_1.id)
      review_2 = book_3.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: user_2.id)
      review_3 = book_4.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: user_3.id)
      review_4 = book_2.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: user_4.id)
      review_5 = book_1.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: user_1.id)
      review_6 = book_2.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: user_1.id)
      review_7 = book_2.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: user_3.id)

      expect(user_1.review_count).to eq(3)
      expect(user_3.review_count).to eq(2)
    end
  end
end
