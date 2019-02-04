class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    author = Author.find(params[:id])
    author.books.each {|b| b.destroy}
    author.destroy
    redirect_to books_path
  end

end
