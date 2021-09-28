require 'rails_helper'


describe 'Visitor visit homepage, filters by property type' do
    it 'and filters by nothing(show all properties normally)' do
      #arrange
      pousada = PropertyType.create!(name: 'pousada')
      casa = PropertyType.create!(name: 'casa')

      rio = PropertyLocation.create!(name: 'rio')

      properties = []

      properties << Property.create!({ 
        title: 'titulo1', 
        description: 'descrição1',
        rooms: 3, 
        bathrooms: 7,
        daily_price: 400,
        property_type: casa,
        property_location: rio,
        parking_available: true
      })
    
      properties << Property.create!({ 
        title: 'titulo2', 
        description: 'descrição2',
        rooms: 20, 
        bathrooms: 2,
        daily_price: 401,
        property_type: pousada,
        property_location: rio,
        parking_available: false
      })

      #act
      visit root_path
      within('div#filtering') do
        click_on 'commit'
      end

      #assert
      within('div#properties') do
          property_css_beginning = 'div#property-'
          expect(page).to have_css(property_css_beginning+"#{properties[0].id}")
          expect(page).to have_css(property_css_beginning+"#{properties[1].id}")
      end

    end

    it 'and have no results after filtering' do
        pousada = PropertyType.create!(name: 'pousada')
        casa = PropertyType.create!(name: 'casa')
        apartamento = PropertyType.create!(name: 'apartamento')
        sitio = PropertyType.create!(name: 'sitio')

        rio = PropertyLocation.create!(name: 'rio')

        properties = []
        properties << Property.create!({ 
          title: 'titulo1', 
          description: 'descrição1',
          rooms: 3, 
          bathrooms: 7,
          daily_price: 400,
          property_type: casa,
          property_location: rio,
          parking_available: true
        })
      
        properties << Property.create!({ 
          title: 'titulo2', 
          description: 'descrição2',
          rooms: 20, 
          bathrooms: 2,
          daily_price: 401,
          property_type: casa,
          property_location: rio,
          parking_available: false
        })
      
        properties << Property.create!({ 
          title: 'titulo2', 
          description: 'descrição2',
          rooms: 2, 
          bathrooms: 9,
          daily_price: 402,
          property_type: sitio,
          property_location: rio,
          parking_available: false
        })
      
        properties << Property.create!({ 
          title: 'casa em copacabana', 
          description: 'uma casa, em copacabana',
          rooms: 3, 
          parking_available: false,
          bathrooms: 32,
          daily_price: 403,
          property_type: apartamento,
          property_location: rio,
          allow_pets: true
        })

        visit root_path
        within('div#filtering') do
            select 'pousada', from: 'property_type_filter'
            click_on 'commit'
        end

        expect(page).to have_css('div#no_properties_note')

    end

    it 'and successfully filters existing properties' do
        properties = []

        casa = PropertyType.create!(name: 'casa')
        apartamento = PropertyType.create!(name: 'apartamento')
        sitio = PropertyType.create!(name: 'sitio')

        rio = PropertyLocation.create!(name: 'rio')
    
        properties << Property.create!({ 
          title: 'titulo1', 
          description: 'descrição1',
          rooms: 3, 
          bathrooms: 7,
          daily_price: 400,
          property_type: casa,
          property_location: rio,
          parking_available: true
        })
      
        properties << Property.create!({ 
          title: 'titulo2', 
          description: 'descrição2',
          rooms: 20, 
          bathrooms: 2,
          daily_price: 401,
          property_type: casa,
          property_location: rio,
          parking_available: false
        })
      
        properties << Property.create!({ 
          title: 'titulo2', 
          description: 'descrição2',
          rooms: 2, 
          bathrooms: 9,
          daily_price: 402,
          property_type: sitio,
          property_location: rio,
          parking_available: false
        })
      
        properties << Property.create!({ 
          title: 'casa em copacabana', 
          description: 'uma casa, em copacabana',
          rooms: 3, 
          parking_available: false,
          bathrooms: 32,
          property_location: rio,
          daily_price: 403,
          property_type: apartamento,
          allow_pets: true
        })

        visit root_path
        select 'casa', from: 'property_type_filter'
        click_on 'commit'

        within('div#properties') do
            property_css_beginning = 'div#property-'
            expect(page).to have_css(property_css_beginning+"#{properties[0].id}")
            expect(page).to have_css(property_css_beginning+"#{properties[1].id}")
            expect(page).to_not have_css(property_css_beginning+"#{properties[2].id}")
            expect(page).to_not have_css(property_css_beginning+"#{properties[3].id}")
        end

    end
end