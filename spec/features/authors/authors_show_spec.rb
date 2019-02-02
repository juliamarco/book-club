require 'rails_helper'

describe 'When I visit /authors/:id' do
  context 'as a visitor' do
    it 'displays all book titles by that author' do

      stephen_king = Author.create(name: "Stephen King")
      herman_melville = Author.create(name: "Herman Melville")
      book_1 = Book.create(title: "IT", page_count: 1168, year: 1986, authors: [stephen_king, herman_melville], cover_image: "https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg")
      book_2 = Book.create(title: "The Shining", page_count: 688, year: 1977, authors: [stephen_king], cover_image: "https://prodimage.images-bn.com/pimages/9780345806789_p0_v1_s550x406.jpg")

      visit author_path(herman_melville)

      expect(page).to have_content(book_1.title)
      expect(page).to have_content("#{stephen_king.name}")
      expect(page).to have_content(book_1.page_count)
      expect(page).to have_content(book_1.year)
      expect(page).to have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9781501142970_p0_v3_s550x406.jpg"]')
      expect(page).to_not have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9780345806789_p0_v1_s550x406.jpg"]')
      expect(page).to_not have_content(book_2.year)
      expect(page).to_not have_content(book_2.page_count)
    end
    end

  end
