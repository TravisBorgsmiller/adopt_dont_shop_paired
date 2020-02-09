class PetsController < ApplicationController
  def index
    @pets = Pet.all
    @shelters = Shelter.all
  end

  def show
    @pet = Pet.find(params[:shelter_id])
    @shelter = Shelter.find(@pet.shelter_id)
  end

  def new
    @shelter_id = params[:shelter_id]
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status == 'pending'
      flash[:error] = "Pet can't be deleted, approved applications exist"
      redirect_to "/pets/#{pet.id}"
    else
      Pet.destroy(params[:id])
      @favorites.remove_pet(pet.id)
      redirect_to '/pets'
    end
  end

  private

    def pet_params
      params.permit(
        :image,
        :name,
        :description,
        :age,
        :sex,
        :status
      )
    end
end
