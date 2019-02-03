require 'rails_helper'

describe 'when I visit /users/:id' do
  context 'as a visitor' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @reverte = Author.create(name: "Arturo Pérez-Reverte")

      @user_1 = User.create(name: "peteristhebest")

      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville], cover_image: "https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg")
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king, @herman_melville])
      @book_3 = Book.create(title: "El asedio", page_count: 290, year: 2005, authors: [@reverte])
      @book_4 = Book.create(title: "Falco", page_count: 400, year: 2010, authors: [@reverte])

      @review_1 = @book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user: @user_1)
      @review_2 = @book_2.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user: @user_1)
      @review_3 = @book_3.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user: @user_1)
    end

    it 'shows all reviews for that user' do
      visit user_path(@user_1)

      expect(page).to have_content(@review_1.title)
      expect(page).to have_content("Rating: #{@review_2.rating}")
      expect(page).to have_content(@review_3.review_text)
      expect(page).to have_content(@book_1.title)

      expect(page).to_not have_content(@book_4.title)
    end

    it 'shows an option to delete a review' do
      visit user_path(@user_1)

      within "#review-#{@review_1.id}" do
        click_button("Delete")
      end

      expect(current_path).to eq(user_path(@user_1))
      expect(page).to_not have_css("#review-#{@review_1.id}")
    end

    it 'shows links to sort reviews chronologically' do

      visit user_path(@user_1)

      within ".sort-reviews" do
        expect(page).to have_link("Sort by newest review")
        expect(page).to have_link("Sort by oldest review")
      end

      click_link ("Sort by newest review")

      reviews = page.find_all('.reviews')
      expect(reviews[0].text).to have_content(@review_1.title)
      expect(reviews[1].text).to have_content(@review_2.title)
      expect(reviews[2].text).to have_content(@review_3.title)

      click_link("Sort by oldest review")

      reviews = page.find_all('.reviews')
      expect(reviews[0].text).to have_content(@review_3.title)
      expect(reviews[1].text).to have_content(@review_2.title)
      expect(reviews[2].text).to have_content(@review_1.title)
      end

    end


  end
