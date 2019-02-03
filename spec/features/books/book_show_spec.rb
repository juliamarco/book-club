require 'rails_helper'

describe 'when I visit /books/:id' do
  context 'as a visitor' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville])
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king, @herman_melville])
    end
    it "I see a page displaying the book matching the id" do

      visit book_path(@book_1)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("#{@stephen_king.name}\n#{@herman_melville.name}")
      expect(page).to have_content(@book_1.page_count)
      expect(page).to have_content(@book_1.year)
      expect(page).to_not have_content(@book_2.title)
      expect(page).to_not have_content(@book_2.year)
      expect(page).to_not have_content(@book_2.page_count)

    end

    it "shows me a link to add a new review for this book" do
      visit book_path(@book_1)

      within "#add-review"

      expect(page).to have_link "Add Review"
      click_link "Add Review"

      expect(current_path).to eq(new_book_review_path(@book_1, @book_1.reviews.ids))
    end

    it "shows an area on the page for statistics about reviews" do
      user_1 = User.create(name: "ilovereading")
      user_2 = User.create(name: "tomas_1999")
      user_3 = User.create(name: "diego_marco")
      user_4 = User.create(name: "joaquin_meteme")
      user_5 = User.create(name: "inma_oteros")
      user_6 = User.create(name: "de_marco_perez")
      user_7 = User.create(name: "noone")
      review_1 = @book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: user_1.id)
      review_2 = @book_1.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: user_2.id)
      review_3 = @book_1.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: user_3.id)
      review_4 = @book_1.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: user_4.id)
      review_5 = @book_1.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: user_7.id)
      review_6 = @book_1.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: user_5.id)
      review_7 = @book_1.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: user_6.id)

      visit book_path(@book_1)

      within "#statistics" do

      expect(page).to_not have_content(user_7.name)
      expect(page).to_not have_content(review_5.title)

      end

      within "#best-reviews" do

      expect(page).to have_content(user_2.name)
      expect(page).to have_content(user_3.name)
      expect(page).to have_content(review_4.title)
      expect(page).to have_content("Rating: #{review_4.rating}")
      expect(page).to_not have_content(user_5.name)

      end

      within "#worst-reviews" do

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_5.name)
      expect(page).to have_content(review_7.title)
      expect(page).to have_content("Rating: #{review_6.rating}")
      expect(page).to_not have_content(user_2.name)

      end
    end

    it 'has username as links that take you to their show page' do
      user_1 = User.create(name: "ilovereading")
      review_1 = @book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user: user_1)

      visit book_path(@book_1)

      within "#user_link" do

      expect(page).to have_link "#{user_1.name}"
      click_link "#{user_1.name}"

      expect(current_path).to eq(user_path(user_1))
      end
    end

  end
end
