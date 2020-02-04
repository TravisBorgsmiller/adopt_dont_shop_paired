class FavoritesController < ApplicationController
  def index
    pet_ids = @favorites.contents.keys
    @pets = pet_ids.reduce([]) do |value, key|
      value << Pet.find(key.to_i)
      value
    end
  end

  def update
    pet = Pet.find(params[:id])
    @favorites.add_favorite_pet(pet.id)
    session[:favorites] = @favorites.contents
    flash[:success] = "#{pet.name} has been added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

end
