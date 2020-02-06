class ApplicationsController < ApplicationController
  def new
    @pets = Application.find_fav_pets(@favorites.contents)
  end

  def create
    application = Application.create(application_params)
    pets = Pet.find(params[:adopt_pets])
    pet_ids = params[:adopt_pets]
    application.pets << pets
    if application.save
      @favorites.delete_favorites(pet_ids)
      flash[:success] = 'Application submitted, thank you!'
      redirect_to '/favorites'
    else
      flash[:error] = 'Application not submitted. Please complete the required fields.'
      render :new
    end
  end
end
  private

  def application_params
    params.permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :description
    )
  end
