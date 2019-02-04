class BooksController < ApplicationController

  def index
    case params[:sort]
      when 'page_count' then @books = Book.by_page_count(params[:order])
      when 'year' then @books = Book.by_year(params[:order])
      when 'rating' then @books = Book.by_rating(params[:order])
      else @books = Book.all
    end
    @top_books = Book.top_books
    @worst_books = Book.worst_books
    @top_reviewers = User.top_reviewers(3)
  end

  def show
    @book = Book.find(params[:id])
    # binding.pry
    @top_reviews = @book.top_reviews(3)
    @bottom_reviews = @book.bottom_reviews(3)
    @average_rating = @book.average_rating
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    @book.authors = params[:book][:authors].split(",").map do |author|
      Author.find_or_create_by(name: author.titleize.strip)
    end
    if @book.save
      redirect_to book_path(@book)
    else
      @authors = Author.all
      render :new
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :year, :cover_image, author_ids: [])
  end

end
