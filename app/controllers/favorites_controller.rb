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

  def destroy
    pet = Pet.find(params[:id])
    favorite.remove_pet(pet.id)
    flash[:notice] = "#{pet.name} has been removed from Favorites!"
    redirect_to '/favorites'
  end
end
