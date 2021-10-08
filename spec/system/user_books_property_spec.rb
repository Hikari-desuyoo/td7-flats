require 'rails_helper'

describe 'user books property' do
    it 'successfully' do
        property_type = PropertyType.create!({name: 'apartamento'})
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        property = Property.create!(
            title: 'apartamento Novo',
            description: 'bom apartamento',
            rooms: 3,
            bathrooms: 2, allow_pets: false, daily_price:100,
            property_type: property_type,
            property_owner: property_owner,
            parking_available: false,
            property_location: PropertyLocation.create!(name: 'rio')
        )

        user = User.create!(email: 'jane2@doe.com.br', password: '123456789')

        login_as user, scope: :user
        visit root_path
        click_on property.title
        fill_in 'Data de início', with: '06/10/2121', :match => :prefer_exact
        fill_in 'Data de término', with: '10/10/2121', :match => :prefer_exact
        fill_in 'Quantidade de pessoas', with: '3'
        click_on 'Enviar reserva'

        expect(page).to have_content('06/10/2121')
        expect(page).to have_content('10/10/2121')
        expect(page).to have_content('3')
        expect(page).to have_content('R$ 400,00')

    end
end