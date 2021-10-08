require 'rails_helper'

describe 'Property owner view reservations' do
    before(:each) do
        property_type = PropertyType.create!(name: 'tipo')
        property_location = PropertyLocation.create!(name: 'local')
        @property_owner1 = PropertyOwner.create!(email: 'nome1@mail.com', password:'123456')
        @property1 = Property.create!(
            title:'titulo1', 
            description: 'descricao1',
            rooms: 2, bathrooms: 3, allow_pets: true, 
            parking_available: false,
            daily_price: 200,
            property_type: property_type,
            property_location: property_location,
            property_owner: @property_owner1
        )

        @property_owner2 = PropertyOwner.create!(email: 'nome2@mail.com', password:'123456')

        @property2 = Property.create!(
            title:'titulo2', 
            description: 'descricao2',
            rooms: 2, bathrooms: 3, allow_pets: true, 
            parking_available: false,
            daily_price: 200,
            property_type: property_type,
            property_location: property_location,
            property_owner: @property_owner2
        )

        @user = User.create!(email: 'nome@mail.com', password:'123456')
    end
    it 'should view reservations from owned properties' do
        a = PropertyReservation.create!(
            start_date: '2121-10-09',
            end_date: '2121-10-10',
            guests: 2,
            property: @property1,
            user: @user
        )

        b = PropertyReservation.create!(
            start_date: '2121-11-09',
            end_date: '2121-11-10',
            guests: 2,
            property: @property2,
            user: @user
        )
        
        login_as @property_owner1, scope: :property_owner
        visit root_path
        click_on 'Meus imóveis'
        click_on 'titulo1'

        expect(page).not_to have_content 'Reserve agora'
        expect(page).to have_content 'Reservas'
        expect(page).to have_content 'Reserva de nome@mail.com'
        expect(page).to have_content 'Data de inicio 09/10/2121'
        expect(page).to have_content 'Data de termino 10/10/2121'
    end
    

end