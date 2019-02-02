require 'rails_helper'

describe 'when I visit /books' do
  context 'as a visitor' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville])
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king, @herman_melville])
    end

    it 'displays all book titles in the database' do
      visit books_path

      within "#book-#{@book_1.id}" do

        expect(page).to have_content(@book_1.title)
        expect(page).to have_content("Pages: #{@book_1.page_count}")
        expect(page).to have_content("Year: #{@book_1.year}")
        expect(page).to have_content("#{@stephen_king.name}")

        expect(page).to_not have_content("Year: #{@book_2.year}")
        expect(page).to_not have_content("Pages: #{@book_2.page_count}")
      end

      within "#book-#{@book_2.id}" do

        expect(page).to have_content(@book_2.title)
        expect(page).to have_content("Pages: #{@book_2.page_count}")
        expect(page).to have_content("Year: #{@book_2.year}")
        expect(page).to have_content("#{@stephen_king.name}")
      end

    end

    it 'all book titles link to the book show page' do
      visit books_path

      within "#book-#{@book_1.id}" do
        expect(page).to have_link(@book_1.title)
        expect(page).to_not have_link(@book_2.title)
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_link(@book_2.title)
        expect(page).to_not have_link(@book_1.title)
      end
    end

    it 'displays multiple authors if present' do

      visit books_path

      within "#book-#{@book_2.id}" do

        expect(page).to have_content(@book_2.title)
        expect(page).to have_content("Pages: #{@book_2.page_count}")
        expect(page).to have_content("Year: #{@book_2.year}")
        expect(page).to have_content("#{@stephen_king.name}\n#{@herman_melville.name}")
      end

    end


    it 'can sort by number of pages in ascending and descending order' do
      visit books_path
      click_link("Sort by Page Count (Ascending)")
      index_of_book_1_title = page.body.index(@book_1.title)
      index_of_book_2_title = page.body.index(@book_2.title)

      expect(index_of_book_2_title).to be < index_of_book_1_title

      click_link("Sort by Page Count (Descending)")

      index_of_book_1_title = page.body.index(@book_1.title)
      index_of_book_2_title = page.body.index(@book_2.title)

      expect(index_of_book_1_title).to be < index_of_book_2_title
    end

    it 'can sort by year in ascending and descending order' do
      visit books_path
      click_link("Sort by Year (Ascending)")
      index_of_book_1_title = page.body.index(@book_1.title)
      index_of_book_2_title = page.body.index(@book_2.title)

      expect(index_of_book_2_title).to be < index_of_book_1_title

      click_link("Sort by Year (Descending)")

      index_of_book_1_title = page.body.index(@book_1.title)
      index_of_book_2_title = page.body.index(@book_2.title)

      expect(index_of_book_1_title).to be < index_of_book_2_title
    end

    it 'can sort by year in ascending and descending order' do
      tim = User.create(name: "Tim")
      review_1 = Review.create(title: "Total ripoff",
                  rating: 2,
                  review_text: "Worst thing ive read this afternoon",
                  book: @book_1,
                  user: tim
                )

      review_2 = Review.create(title: "Amazing",
                  rating: 5,
                  review_text: "I take it all back, the clown is pure evil.",
                  book: @book_1,
                  user: tim
                )

      review_3 = Review.create(title: "Meh",
                  rating: 3,
                  review_text: "Doesn't have clowns. Kinda boring.",
                  book: @book_2,
                  user: tim
                )

      visit books_path
      click_link("Sort by Rating (Ascending)")
      index_of_book_1_title = page.body.index(@book_1.title)
      index_of_book_2_title = page.body.index(@book_2.title)

      expect(index_of_book_1_title).to be < index_of_book_2_title

      click_link("Sort by Rating (Descending)")

      index_of_book_1_title = page.body.index(@book_1.title)
      index_of_book_2_title = page.body.index(@book_2.title)

      expect(index_of_book_2_title).to be < index_of_book_1_title
    end
  end


end
