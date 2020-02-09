class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def create
    Shelter.create(shelter_params)

    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)

    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])

    if shelter.pets.empty?
      flash[:success] = 'Shelter Removed.'
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
    shelter.pets.each do |pet|
      if pet.status == 'pending'
        flash[:error] = 'Pets Pending for Adoption. Resolve Before Deleting.'
        redirect_to '/shelters'
        break
      else
        flash[:success] = 'Shelter Removed.'
        Shelter.destroy(params[:id])
        redirect_to '/shelters'
      end
    end
  end

  def pets_index
    @shelter = Shelter.find(shelter_params[:id])
  end

  private

  def shelter_params
    params.permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :id
    )
  end
end
