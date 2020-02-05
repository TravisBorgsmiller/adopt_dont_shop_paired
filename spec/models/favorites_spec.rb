require 'rails_helper'

RSpec.describe Favorite do
  describe "#add_pet" do
    it "can add pet to favorite pets" do
      favorites = Favorite.new({
        "1" => 1,
        "2" => 1
        })
      favorites.add_favorite_pet("3")
      expect(favorites.contents.count).to eq(3)
    end
  end
  describe "total_count" do
    it "can give total_count of favorite pets" do
      favorites = Favorite.new({
        "1" => 1
        })
      expect(favorites.total_count).to eq(1)
    end
  end
  describe "initialize" do
    it "can initialize favorite pets" do
      favorites = Favorite.new({})
      expect(favorites.contents.count). to eq(0)
    end
  end
end
