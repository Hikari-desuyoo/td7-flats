require 'rails_helper'

def preset_properties
  properties = []
  property_type = PropertyType.create(name: 'casa')
  property_location = PropertyLocation.create(name: 'rio de janeiro')
  property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
  properties << Property.create!({ 
    title: 'titulo1', 
    description: 'descrição1',
    rooms: 3, 
    bathrooms: 7,
    daily_price: 400,
    property_type: property_type,
    property_location: property_location,
    property_owner: property_owner,
    parking_available: true
  })

  properties << Property.create!({ 
    title: 'titulo2', 
    description: 'descrição2',
    rooms: 20, 
    bathrooms: 2,
    daily_price: 401,
    property_type: property_type,
    property_owner: property_owner,
    property_location: property_location,
    parking_available: false
  })

  properties << Property.create!({ 
    title: 'titulo2', 
    description: 'descrição2',
    rooms: 2, 
    bathrooms: 9,
    daily_price: 402,
    property_type: property_type,
    property_owner: property_owner,
    property_location: property_location,
    parking_available: false
  })

  properties << Property.create!({ 
    title: 'casa em copacabana', 
    description: 'uma casa, em copacabana',
    rooms: 3, 
    parking_available: false,
    bathrooms: 32,
    property_owner: property_owner,
    daily_price: 403,
    property_type: property_type,
    property_location: property_location,
    allow_pets: true
  })
  properties
end

def sim_nao(boolean)
  boolean ? "sim" : "não"
end

describe 'Visitor visit homepage' do
  it 'and successfully sees existing properties' do
    properties = preset_properties

    visit root_path

    expect(page).to have_no_css('div#no_properties_note')
    properties.each do |property|    
      property_css_beginning = "div#property-#{property.id} ."
      expect(page).to have_css(property_css_beginning + 'title', text: property.title)
      expect(page).to have_css(property_css_beginning + 'description', text: property.description)
    end

  end

  it 'and sees a note if there are no properties' do
    visit root_path

    expect(page).to have_css('div#no_properties_note')
  end

  it 'and sees details of properties upon clicking its title' do
    properties = preset_properties

    visit root_path

    find("div#property-#{properties[0].id} .details_link").click

    css_beginning = "div#information ."
    expect(page).to have_css(css_beginning + 'title', text: properties[0].title)
    expect(page).to have_css(css_beginning + 'description', text: properties[0].description)
    expect(page).to have_css(css_beginning + 'rooms', text: properties[0].rooms.to_s)
    expect(page).to have_css(css_beginning + 'allow_pets', text: sim_nao(properties[0].allow_pets))
    expect(page).to have_css(css_beginning + 'daily_price', text: properties[0].daily_price.to_i)
    expect(page).to have_css(css_beginning + 'rooms', text: properties[0].rooms.to_s)
    expect(page).to have_css(css_beginning + 'bathrooms', text: properties[0].bathrooms.to_s)
    expect(page).to have_css(css_beginning + 'parking_available', text: sim_nao(properties[0].parking_available))
  end

  it 'and goes back to menu' do
    properties = preset_properties

    visit root_path
    find("div#property-#{properties[0].id} .details_link").click
    find(".back_button").click

    expect(current_path).to eq root_path
  end


end