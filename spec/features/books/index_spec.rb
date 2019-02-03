require 'rails_helper'

describe 'when I visit /books' do
  context 'as a visitor' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville])
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king, @herman_melville])
      @book_3 = Book.create(title: "The Colorado Kid", page_count: 702, year: 1984, authors: [@stephen_king])
      @book_4 = Book.create(title: "Carrie", page_count: 404, year: 1999, authors: [@stephen_king])
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

      books = page.find_all('.books-index')
      expect(books[0].text).to have_content(@book_4.title)
      expect(books[1].text).to have_content(@book_2.title)
      expect(books[2].text).to have_content(@book_3.title)
      expect(books[3].text).to have_content(@book_1.title)
      click_link("Sort by Page Count (Descending)")

      books = page.find_all('.books-index')
      expect(books[0].text).to have_content(@book_1.title)
      expect(books[1].text).to have_content(@book_3.title)
      expect(books[2].text).to have_content(@book_2.title)
      expect(books[3].text).to have_content(@book_4.title)
    end

    it 'can sort by year in ascending and descending order' do
      visit books_path
      click_link("Sort by Year (Ascending)")
      books = page.find_all('.books-index')
      expect(books[0].text).to have_content(@book_2.title)
      expect(books[1].text).to have_content(@book_3.title)
      expect(books[2].text).to have_content(@book_1.title)
      expect(books[3].text).to have_content(@book_4.title)

      click_link("Sort by Year (Descending)")

      books = page.find_all('.books-index')
      expect(books[0].text).to have_content(@book_4.title)
      expect(books[1].text).to have_content(@book_1.title)
      expect(books[2].text).to have_content(@book_3.title)
      expect(books[3].text).to have_content(@book_2.title)
    end

    it 'can sort by rating in ascending and descending order' do
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
      books = page.find_all('.books-index')
      expect(books[0].text).to have_content(@book_3.title)
      expect(books[1].text).to have_content(@book_4.title)
      expect(books[2].text).to have_content(@book_2.title)
      expect(books[3].text).to have_content(@book_1.title)

      click_link("Sort by Rating (Descending)")

      books = page.find_all('.books-index')
      expect(books[0].text).to have_content(@book_1.title)
      expect(books[1].text).to have_content(@book_2.title)
      expect(books[2].text).to have_content(@book_3.title)
      expect(books[3].text).to have_content(@book_4.title)
    end

    describe 'it has a statistics area at the top of the page' do
      before :each do
        @user_1 = User.create(name: "ilovereading")
        @user_2 = User.create(name: "tomas_1999")
        @user_3 = User.create(name: "diego_marco")
        @user_4 = User.create(name: "joaquin_meteme")
        @review_1 = @book_1.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: @user_1.id)
        @review_2 = @book_3.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: @user_2.id)
        @review_3 = @book_4.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: @user_3.id)
        @review_4 = @book_3.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: @user_4.id)
        @review_5 = @book_1.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: @user_1.id)
        @review_6 = @book_2.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: @user_1.id)
        @review_7 = @book_2.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: @user_3.id)
        # Book_1 : 2.5, Book_2 : 1.5, Book_3 : 4.5, Book_4 : 5
        # User_1 : 3, User_2 : 1, User_3 : 2, User_4 : 1
      end

      it 'shows three of the highest rated books' do
        visit books_path

        expected = "#{@book_4.title} Score: #{@book_4.average_rating} "
        expected += "#{@book_3.title} Score: #{@book_3.average_rating} "
        expected += "#{@book_1.title} Score: #{@book_1.average_rating}"

        within '#top-books' do
          expect(page).to have_content(expected)
        end
      end

      it 'shows three of the lowest rated books' do
        visit books_path

        expected = "#{@book_2.title} Score: #{@book_2.average_rating} "
        expected += "#{@book_1.title} Score: #{@book_1.average_rating} "
        expected += "#{@book_3.title} Score: #{@book_3.average_rating}"

        within '#worst-books' do
          expect(page).to have_content(expected)
        end
      end

      it 'shows three of the users who have written the most reviews' do
        visit books_path

        expected = "#{@user_1.name} Reviews: #{@user_1.review_count} "
        expected += "#{@user_3.name} Reviews: #{@user_3.review_count} "
        expected += "#{@user_2.name} Reviews: #{@user_2.review_count}"

        within '#top-reviewers' do
          expect(page).to have_content(expected)
        end
      end
    end
  end


end
