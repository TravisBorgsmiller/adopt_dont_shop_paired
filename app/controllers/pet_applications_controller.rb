class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update(status: 'pending')

    redirect_to "/pets/#{pet.id}"
  end
end
