class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @user = User.find_or_create_by(name: params[:review][:user].titleize)
    @review = @book.reviews.new(review_params)
    @review.user = @user

    if @review.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to user_path(review.user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :review_text, :book_id)
  end


end
