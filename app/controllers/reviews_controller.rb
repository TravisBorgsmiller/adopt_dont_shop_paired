class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.new(review_params)
    if review.save
      binding.pry
      flash[:success] = 'Review Created!'
      redirect_to "/shelters/#{@shelter.id}"
    else
      binding.pry
      flash.now[:error] = review.errors.full_messages.to_sentence
      redirect_to "/shelters/#{@shelter.id}"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      flash[:success] = 'Review updated!'
      redirect_to "/shelters/#{@review.shelter_id}"
    else
      flash.now[:error] = 'Review not updated. Please complete required fields.'
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    Review.destroy(params[:id])

    redirect_to "/shelters/#{review.shelter_id}"
  end
end

  private

  def review_params
    params.permit(:title, :rating, :content, :image, :shelter_id)
  end
