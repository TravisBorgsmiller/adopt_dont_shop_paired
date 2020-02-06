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
    if params[:id]
      pet = Pet.find(params[:id])
      favorite.remove_pet(pet.id)
      flash[:notice] = "#{pet.name} has been removed from Favorites!"
    else
      favorite.remove_all
      flash[:notice] = "Your favorited pets have been removed"
   end
    redirect_to "/favorites"
    session[:favorites] = favorite.contents
  end

end
