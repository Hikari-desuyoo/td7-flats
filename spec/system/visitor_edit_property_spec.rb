require 'rails_helper'

def sim_nao(boolean)
    boolean ? "sim" : "não"
  end

describe 'Visitor visit homepage, clicks first edit button' do
  it 'and successfully edits its title' do
    property_type = PropertyType.create(name: 'casa')
    rio = PropertyLocation.create!(name: 'rio')

    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    Property.create!({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true,
      allow_pets: false,
      daily_price: 400.25,
      property_owner: property_owner,
      bathrooms: 5,
      property_location: rio, 
      property_type: property_type
    })

    visit root_path
    find("div#property-1 .details_link").click
    find('#edit_link').click

    fill_in 'property_title', with: 'titulo2'
    click_on 'commit'


    css_beginning = 'div#information .'
    expect(page).to have_css(css_beginning + 'title', text: 'titulo2') 
    expect(page).to have_css(css_beginning + 'description', text: 'descrição1')
    expect(page).to have_css(css_beginning + 'rooms', text: '3')
    expect(page).to have_css(css_beginning + 'bathrooms', text: '5')
    expect(page).to have_css(css_beginning + 'allow_pets', text: 'não')
    expect(page).to have_css(css_beginning + 'daily_price', text: '400,25')
    expect(page).to have_css(css_beginning + 'parking_available', text: 'sim')
    expect(page).to have_css(css_beginning + 'property_type', text: 'Casa')
  end

  it 'and successfully edits its type' do
    casa = PropertyType.create(name: 'casa')
    apartamento = PropertyType.create(name: 'apartamento')

    rio = PropertyLocation.create!(name: 'rio')

    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    Property.create!({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true,
      allow_pets: false,
      daily_price: 400.25,
      property_owner: property_owner,
      bathrooms: 5,
      property_location: rio, 
      property_type: apartamento
    })

    visit root_path
    find("div#property-1 .details_link").click
    find('#edit_link').click

    select 'casa', from: 'property_property_type_id'
    click_on 'commit'

    css_beginning = 'div#information .'
    expect(page).to have_css(css_beginning + 'property_type', text: 'Casa')
  end

  it 'and successfully edits its location' do
    apartamento = PropertyType.create(name: 'apartamento')

    rio = PropertyLocation.create!(name: 'rio')
    minas = PropertyLocation.create!(name: 'minas')

    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

    Property.create!({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true,
      allow_pets: false,
      property_owner: property_owner,
      daily_price: 400.25,
      bathrooms: 5,
      property_location: rio, 
      property_type: apartamento
    })

    visit root_path
    find("div#property-1 .details_link").click
    find('#edit_link').click

    select 'minas', from: 'property_property_location_id'
    click_on 'commit'

    css_beginning = 'div#information .'
    expect(page).to have_css(css_beginning + 'property_location', text: 'minas')
  end

  it 'and after not editing property_type, property_type doesnt change' do
    casa = PropertyType.create(name: 'casa')
    apartamento = PropertyType.create(name: 'apartamento')

    property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
    
    rio = PropertyLocation.create!(name: 'rio')

    Property.create!({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true,
      allow_pets: false,
      daily_price: 400.25,
      bathrooms: 5,
      property_owner: property_owner,
      property_location: rio, 
      property_type: apartamento
    })

    visit root_path
    find("div#property-1 .details_link").click
    find('#edit_link').click

    click_on 'commit'

    css_beginning = 'div#information .'
    expect(page).to have_css(css_beginning + 'property_type', text: 'Apartamento')

  end
end