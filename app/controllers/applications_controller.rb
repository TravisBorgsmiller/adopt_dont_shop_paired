class ApplicationsController < ApplicationController
  def new
    @pets = Application.find_fav_pets(@favorites.contents)
  end

  def create
    application = Application.new(application_params)

    if application.save
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
      :description,
      :pet_id
    )
  end
