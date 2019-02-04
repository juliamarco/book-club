require 'rails_helper'

describe 'When I visit /authors/:id' do
  context 'as a visitor' do
    before :each do
      @stephen_king = Author.create(name: "Stephen King")
      @herman_melville = Author.create(name: "Herman Melville")
      @book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [@stephen_king, @herman_melville], cover_image: "https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg")
      @book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [@stephen_king], cover_image: "https://prodimage.images-bn.com/pimages/9780345806789_p0_v1_s550x406.jpg")
      @tim = User.create(name: "tim")
      @review = @book_1.reviews.create(user: @tim, title: "So spooky", rating: 4, review_text: "Literally made me cry.")
    end

    it 'displays all book titles by that author' do


      visit author_path(@herman_melville)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("#{@stephen_king.name}")
      expect(page).to have_content(@book_1.page_count)
      expect(page).to have_content(@book_1.year)
      expect(page).to have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg"]')
      expect(page).to have_content("Top Review: #{@review.title}")
      expect(page).to have_content(@review.user.name)
      expect(page).to have_content(@review.review_text)
      expect(page).to_not have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9780345806789_p0_v1_s550x406.jpg"]')
      expect(page).to_not have_content(@book_2.year)
      expect(page).to_not have_content(@book_2.page_count)
    end

    it 'can display multiple book titles for author' do

      visit author_path(@stephen_king)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("#{@herman_melville.name}")
      expect(page).to have_content("Page Count: #{@book_1.page_count}")
      expect(page).to have_content("Year: #{@book_1.year}")
      expect(page).to have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg"]')
      expect(page).to have_content("Top Review: #{@review.title}")
      expect(page).to have_content(@review.user.name)
      expect(page).to have_content(@review.review_text)
      expect(page).to have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9780345806789_p0_v1_s550x406.jpg"]')
      expect(page).to have_content("Year: #{@book_2.year}")
      expect(page).to have_content("Page Count: #{@book_2.page_count}")
      expect(page).to have_content("Book has no reviews")
    end

    it 'has a link to delete the author' do
      visit author_path(@herman_melville)

      click_link("Delete Author")

      expect(current_path).to eq(books_path)

      expect(page).to_not have_css("#book-#{@book_1.id}")
      expect(page).to have_content(@stephen_king.name)
      expect(page).to have_content(@book_2.title)
      expect(page).to_not have_content(@herman_melville.name)
    end
  end
end
