require 'rails_helper'

describe 'when I visit /books' do
  context 'as a visitor' do
    it 'displays all book titles in the database' do
      stephen_king = Author.create(name: "Stephen King")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986)
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977)
      BookAuthor.create(author: stephen_king, book: book_1)
      BookAuthor.create(author: stephen_king, book: book_2)

      visit '/books'

      within "#book-#{book_1.id}" do

        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Pages: #{book_1.page_count}")
        expect(page).to have_content("Year: #{book_1.year}")
        expect(page).to have_content(book_1.authors.pluck(:name).join("\n"))

        expect(page).to_not have_content("Year: #{book_2.year}")
        expect(page).to_not have_content("Pages: #{book_2.page_count}")
      end

      within "#book-#{book_2.id}" do

        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Pages: #{book_2.page_count}")
        expect(page).to have_content("Year: #{book_2.year}")
        expect(page).to have_content(book_2.authors.pluck(:name).join("\n"))
      end

    end

    it 'displays multiple authors if present' do
      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986)
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977)
      BookAuthor.create(author: stephen_king, book: book_1)
      BookAuthor.create(author: stephen_king, book: book_2)
      BookAuthor.create(author: herman_melville, book: book_2)

      visit '/books'

      within "#book-#{book_2.id}" do

        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Pages: #{book_2.page_count}")
        expect(page).to have_content("Year: #{book_2.year}")
        expect(page).to have_content(book_2.authors.pluck(:name).join("\n"))

        expect(page).to_not have_content("Year: #{book_1.year}")
        expect(page).to_not have_content("Pages: #{book_1.page_count}")
      end

    end
  end


end
