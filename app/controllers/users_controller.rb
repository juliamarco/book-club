class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    case params[:sort]
    when 'id' then @reviews = @user.reviews.by_id(params[:order])
      else @reviews = @user.reviews
    end
  end

end
