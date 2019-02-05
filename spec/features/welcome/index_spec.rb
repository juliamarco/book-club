require 'rails_helper'

describe 'when I visit /' do
  context 'as a visitor' do
    it 'displays a navigation bar' do
      visit root_path

      expect(page).to have_content("Welcome to our Book Club")

      click_link("All Books")
      expect(current_path).to eq(books_path)

      click_link("Home Page")
      expect(current_path).to eq(root_path)
    end

  end
end
