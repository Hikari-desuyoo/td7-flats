require 'rails_helper'

describe 'Property owner view own properties' do
    it 'using menu' do
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

        login_as property_owner, scope: :property_owner
        visit root_path

        expect(page).to have_link("Meus imóveis", href: 'my_properties_properties')
    end

    it 'and should view owned properties' do
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        property_type = PropertyType.create!(name: 'Casa')
        property_location = PropertyLocation.create!(name: 'Rio')
        property1 = Property.create!({ 
            title: 'titulo1', 
            description: 'descrição1',
            rooms: 3, 
            bathrooms: 7,
            daily_price: 400,
            property_type: property_type,
            property_location: property_location,
            parking_available: true,
            property_owner: property_owner
          })

        property_owner2 = PropertyOwner.create!(email: 'jane2@doe.com.br', password: '123456789')
        property2 = Property.create!({ 
            title: 'titulo2', 
            description: 'descrição2',
            rooms: 3, 
            bathrooms: 7,
            daily_price: 400,
            property_type: property_type,
            property_location: property_location,
            parking_available: true,
            property_owner: property_owner2
          })
        
        #Act
        login_as property_owner, scope: :property_owner
        visit root_path
        click_on 'Meus Imóveis'

        #Assert
        expect(page).to have_content property1.title
        expect(page).not_to have_content property2.title
        
    end

end