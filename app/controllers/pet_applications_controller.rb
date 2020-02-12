class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    if pet.status == 'pending'
      pet.update(status: 'adoptable')
      pet.update(pending_for: 'none')
      redirect_to "/applications/#{params[:application_id]}"
    else
      pet.update(status: 'pending')
      pet.update(pending_for: params[:application_id].to_s)
      redirect_to "/pets/#{pet.id}"
    end
  end
end
