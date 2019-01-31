class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    authors_in_database = Author.all.pluck(:name)
    @book.authors = params[:book][:authors].split(", ").map do |author|
      if !authors_in_database.include?(author)
        Author.create(name: author)
      else
        Author.find_by(name: author)
      end
    end
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :year, :cover_image, author_ids: [])
  end

end
