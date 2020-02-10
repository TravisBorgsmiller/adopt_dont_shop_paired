class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      flash[:success] = 'Shelter successfully created'
      redirect_to '/shelters'
    else
      flash[:error] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    if @shelter.update(shelter_params)
      flash[:success] = 'Shelter successfully updated'
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = @shelter.errors.full_messages.to_sentence
      render :edit
    end
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
