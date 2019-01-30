require 'rails_helper'

describe 'when I visit /books/new' do
  context 'as a visitor' do
    it "shows me a form to add a new book" do
      jim = Author.create(name: "Jim Gaffigan")
      jim.books.create(title: "How to make people laugh", page_count: 1, year: 2025)
      author_1_name = "Stephen King"
      author_2_name = "Harper Lee"

      visit new_book_path

      fill_in "book[title]", with: "IT"
      fill_in "book[author]", with: "#{author_1_name}, #{author_2_name}"
      fill_in "book[year]", with: "1999"
      fill_in "book[page_count]", with: "200"

      click_on "Add Book"

      expect(page).to have_content("IT")
      expect(page).to have_content("#{author_1_name}, #{author_2_name}")
      expect(page).to have_content("Year: 1999")
      expect(page).to have_content("Pages: 200")
      expect(page).to_not have_content(jim.name)
      expect(Author.count).to eq(2)
    end
  end
end
