require 'rails_helper'

describe 'when I visit /books/:id' do
  context 'as a visitor' do
    it "I see a page displaying the book matching the id" do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986)
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977)
      BookAuthor.create(author: stephen_king, book: book_1)
      BookAuthor.create(author: herman_melville, book: book_1)
      BookAuthor.create(author: stephen_king, book: book_2)

      visit book_path(book_1)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_1.authors.pluck(:name).join("\n"))
      expect(page).to have_content(book_1.page_count)
      expect(page).to have_content(book_1.year)
      expect(page).to_not have_content(book_2.title)
      expect(page).to_not have_content(book_2.year)
      expect(page).to_not have_content(book_2.page_count)
    end
  end
end
