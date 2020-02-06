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
    if params[:delete_or_favorite] == "favorite"
      @favorites.add_favorite_pet(pet.id)
      session[:favorites] = @favorites.contents
      flash[:success] = "#{pet.name} has been added to your favorites!"
      redirect_to "/pets/#{pet.id}"
    else
      @favorites.remove_pet(pet.id)
      session[:favorites] = @favorites.contents
      flash[:success] = "#{pet.name} has been removed from Favorites!"
      redirect_to "/favorites"
    end
  end

  def destroy
    favorite.remove_all
    flash[:notice] = "Your favorited pets have been removed"
    redirect_to "/favorites"
    session[:favorites] = favorite.contents
  end
end
