class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @user = User.find_or_create_by(name: review_params[:user].titleize)
    @review = @book.reviews.create(title: review_params[:title], user: @user, rating: review_params[:rating], review_text: review_params[:review_text] )

    if @review.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :user, :rating, :review_text, :book_id)
  end


end
