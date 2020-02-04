class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(review_params)
    if review.save
      flash[:success] = 'Review created!'
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:error] = 'Review not created. Please complete required fields.'
      render :new
    end
  end

end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
