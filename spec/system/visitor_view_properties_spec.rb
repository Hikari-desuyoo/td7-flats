require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'and successfully sees existing properties' do

    properties = []
    properties << Property.create({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true
    })

    properties << Property.create({ 
      title: 'titulo2', 
      description: 'descrição2',
      rooms: 20, 
      parking_available: false
    })

    properties << Property.create({ 
      title: 'titulo2', 
      description: 'descrição2',
      parking_available: false
    })

    properties << Property.create({ 
      title: 'casa em copa cabana', 
      description: 'uma casa, em copa cabana',
      parking_available: false,
      allow_pets: true
    })

    visit root_path

    expect(page).to have_no_css('div#no_properties_note')
    properties.each do |property|    
      property_css_beginning = "div#property-#{property.id} > #"
      expect(page).to have_css(property_css_beginning + 'title', text: property.title)
      expect(page).to have_css(property_css_beginning + 'description', text: property.description)
      expect(page).to have_css(property_css_beginning + 'rooms', text: property.rooms.to_s)
      expect(page).to have_css(property_css_beginning + 'parking_available', text: property.parking_available ? 'sim' : 'não')
    end

  end

  it 'and sees a note if there are no properties' do
    visit root_path

    expect(page).to have_css('div#no_properties_note')
  end
end