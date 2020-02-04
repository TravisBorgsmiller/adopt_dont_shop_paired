class FavoritesController < ApplicationController
  def index
  end

  def update
    pet = Pet.find(params[:id])
    @favorites.add_favorite_pet(pet.id)
    session[:favorites] = @favorites.contents
    flash[:success] = "#{pet.name} has been added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

end
