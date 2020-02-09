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
      Shelter.destroy(params[:id])
      flash[:success] = 'Shelter Removed.'
    elsif shelter.pets.find_by(status: 'pending')
      flash[:error] = 'Pets Pending for Adoption. Resolve Before Deleting.'
    else
      Shelter.destroy(params[:id])
      flash[:success] = 'Shelter Removed.'
    end
    redirect_to '/shelters'
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
