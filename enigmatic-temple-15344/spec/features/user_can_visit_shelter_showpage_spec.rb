require 'rails_helper'

RSpec.describe 'As a vistior', type: :feature do
  describe 'When I visit a shelter\'s showpage' do
    it 'I see the shelter\'s name, address, city, state, and zip' do
      shelter1 = Shelter.create(name: 'Pet Palace',
                                address: '4231 Ponderosa Court',
                                city: 'Boulder',
                                state: 'CO',
                                zip: '80301')

      visit "/shelters/#{shelter1.id}"

      expect(page).to have_content(shelter1.name)
      expect(page).to have_content(shelter1.address)
      expect(page).to have_content(shelter1.city)
      expect(page).to have_content(shelter1.state)
      expect(page).to have_content(shelter1.zip)
    end
  end
end
