class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    app = PetApplication.find_by(application_id: params[:application_id])
    pet = Pet.find(params[:pet_id])
    if pet.status == 'pending'
      pet.update(status: 'adoptable')
      app.update(pending: 'false')
      redirect_to "/applications/#{app.application_id}"
    else
      pet.update(status: 'pending')
      app.update(pending: 'true')
      redirect_to "/pets/#{pet.id}"
    end
  end
end
