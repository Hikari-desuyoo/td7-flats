require 'rails_helper'

def preset_properties
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
    title: 'casa em copacabana', 
    description: 'uma casa, em copacabana',
    parking_available: false,
    allow_pets: true
  })
  properties
end

def sim_nao(boolean)
  boolean ? "sim" : "nao"
end

describe 'Visitor visit homepage' do
  it 'and successfully sees existing properties' do
    properties = preset_properties

    visit root_path

    expect(page).to have_no_css('div#no_properties_note')
    properties.each do |property|    
      property_css_beginning = "div#property-#{property.id} > #"
      expect(page).to have_css(property_css_beginning + 'title', text: property.title)
      expect(page).to have_css(property_css_beginning + 'description', text: property.description)
      expect(page).to have_css(property_css_beginning + 'rooms', text: property.rooms.to_s)
      expect(page).to have_css(property_css_beginning + 'parking_available', text: sim_nao(property.parking_available))
    end

  end

  it 'and sees a note if there are no properties' do
    visit root_path

    expect(page).to have_css('div#no_properties_note')
  end

  it 'and sees details of properties upon clicking its title' do
    properties = preset_properties

    visit root_path

    find("div#property-#{properties[0].id} > .details_link").click

    css_beginning = "div#information > #"
    expect(page).to have_css(css_beginning + 'title', text: properties[0].title)
    expect(page).to have_css(css_beginning + 'description', text: properties[0].description)
    expect(page).to have_css(css_beginning + 'rooms', text: properties[0].rooms.to_s)
    expect(page).to have_css(css_beginning + 'allow_pets', text: sim_nao(property[0].allow_pets))
    expect(page).to have_css(css_beginning + 'daily_price', text: properties[0].daily_price.to_s)
    expect(page).to have_css(css_beginning + 'rooms', text: properties[0].rooms.to_s)
    expect(page).to have_css(css_beginning + 'bathrooms', text: properties[0].bathrooms.to_s)
    expect(page).to have_css(css_beginning + 'parking_available', text: sim_nao(property[0].parking_available))
  end

  it 'and goes back to menu' do
    properties = preset_properties

    visit root_path
    find("div#property-#{properties[0].id} > .details_link").click
    find(".back_button").click

    expect(current_path).to eq root_path
  end


end