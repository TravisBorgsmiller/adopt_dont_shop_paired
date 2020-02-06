class ApplicationsController < ApplicationController
  def new
    binding.pry
    @pets = Application.find_pets(@favorites.contents)
  end
end
