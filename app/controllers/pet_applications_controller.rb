class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    app = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    if pet.status == 'pending'
      pet.update(status: 'adoptable')
      redirect_to "/applications/#{app.id}"
    else
      pet.update(status: 'pending')
      redirect_to "/pets/#{pet.id}"
    end
  end
end
