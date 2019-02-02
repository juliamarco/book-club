require 'rails_helper'

describe 'when I visit /books/:id' do
  context 'as a visitor' do
    it "I see a page displaying the book matching the id" do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville])
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king])

      visit book_path(book_1)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content("#{stephen_king.name}\n#{herman_melville.name}")
      expect(page).to have_content(book_1.page_count)
      expect(page).to have_content(book_1.year)
      expect(page).to_not have_content(book_2.title)
      expect(page).to_not have_content(book_2.year)
      expect(page).to_not have_content(book_2.page_count)
    end
  end

  it "shows me a link to add a new review for this book" do
    herman_melville = Author.create(name: "Herman Melville")
    stephen_king = Author.create(name: "Stephen King")
    book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville], cover_image: "https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg")

    visit book_path(book_1)

    within "#add-review"

    expect(page).to have_link "Add Review"
    click_link "Add Review"

    expect(current_path).to eq(new_book_review_path(book_1, book_1.reviews.ids))
  end
end
