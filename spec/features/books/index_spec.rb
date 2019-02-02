require 'rails_helper'

describe 'when I visit /books' do
  context 'as a visitor' do
    it 'displays all book titles in the database' do
      stephen_king = Author.create(name: "Stephen King")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king])
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king])

      visit books_path

      within "#book-#{book_1.id}" do

        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Pages: #{book_1.page_count}")
        expect(page).to have_content("Year: #{book_1.year}")
        expect(page).to have_content("#{stephen_king.name}")

        expect(page).to_not have_content("Year: #{book_2.year}")
        expect(page).to_not have_content("Pages: #{book_2.page_count}")
      end

      within "#book-#{book_2.id}" do

        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Pages: #{book_2.page_count}")
        expect(page).to have_content("Year: #{book_2.year}")
        expect(page).to have_content("#{stephen_king.name}")
      end

    end

    it 'all book titles link to the book show page' do
      stephen_king = Author.create(name: "Stephen King")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king])
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king])

      visit books_path

      within "#book-#{book_1.id}" do
        expect(page).to have_link(book_1.title)
        expect(page).to_not have_link(book_2.title)
      end

      within "#book-#{book_2.id}" do
        expect(page).to have_link(book_2.title)
        expect(page).to_not have_link(book_1.title)
      end
    end

    it 'displays multiple authors if present' do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville])
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king, herman_melville])

      visit books_path

      within "#book-#{book_2.id}" do

        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Pages: #{book_2.page_count}")
        expect(page).to have_content("Year: #{book_2.year}")
        expect(page).to have_content("#{stephen_king.name}\n#{herman_melville.name}")
      end

    end
  end


end
