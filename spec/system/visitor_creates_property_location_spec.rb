def register_location(name)
    fill_in 'property_location_name', with: name
    click_on 'commit'
end

describe 'Visitor visit homepage' do
    it 'clicks location register button, and successfully creates new property location' do
        #arrange

        #act
        visit root_path
        find("#location_register_link").click
        register_location('loc_teste')
        corresponding_locations = PropertyLocation.where(name: 'LOC_TESTE')

        #assert
        expect(corresponding_locations.length).to eq 1
        expect(current_path).to eq root_path
    end

    it 'clicks location register button, and successfully creates new property location converted to uppercase' do
        #arrange

        #act
        visit root_path
        find("#location_register_link").click
        register_location('LOC_teste')
        corresponding_locations = PropertyLocation.where(name: 'LOC_TESTE')

        #assert
        expect(corresponding_locations.length).to eq 1
        expect(current_path).to eq root_path
    end

    it 'clicks location register button, and show error when creating already existing property location' do
        #arrange
        PropertyLocation.create!(name: 'LOC_TESTE')

        #act
        visit root_path
        find("#location_register_link").click
        register_location('loc_teste')

        #assert
        expect(page).to have_content('Nome da região já está em uso')
    end

    it 'clicks register button, clicks location register button, and gets redirected to register page again' do
        #arrange

        #act
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

        login_as property_owner, scope: :property_owner
        visit root_path
        find("#register_link").click
        register_path = current_path
        find("#location_register_link").click
        register_location('loc_teste')

        #assert
        expect(current_path).to eq register_path
    end

    it 'clicks location register button and goes back (to menu)' do
        visit root_path
        find("#location_register_link").click
        find(".back_button").click
    
        expect(current_path).to eq root_path
      end

    it 'clicks location register button and goes back (to register page)' do
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

        login_as property_owner, scope: :property_owner
        visit root_path
        find("#register_link").click
        register_path = current_path
        find("#location_register_link").click
        find(".back_button").click
    
        expect(current_path).to eq register_path
    end
end