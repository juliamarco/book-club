require 'rails_helper'

describe 'When I visit books/:id/review/new' do
  context 'as a visitor' do
    it 'shows me a form to add a new review' do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville], cover_image: "https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg")
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king], cover_image: "https://prodimage.images-bn.com/pimages/9780345806789_p0_v1_s550x406.jpg")

      visit new_book_review_path(book_1, book_1.reviews.ids)

      fill_in "review[title]", with: "Best book ever"
      fill_in "review[user]", with: "megustaleer"
      fill_in "review[rating]", with: 5
      fill_in "review[review_text]", with: "I read it in two days"
      # save_and_open_page
      click_button "Add Review"

      expect(current_path).to eq(book_path(book_1))
    end
  end
end
