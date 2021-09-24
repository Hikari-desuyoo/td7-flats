require 'rails_helper'

def sim_nao(boolean)
    boolean ? "sim" : "não"
  end

describe 'Visitor visit homepage, clicks first edit button' do
  it 'and successfully edits its title' do
    Property.create({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true,
      allow_pets: false,
      daily_price: 400.25,
      bathrooms: 5
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
    expect(page).to have_css(css_beginning + 'daily_price', text: '400.25')
    expect(page).to have_css(css_beginning + 'parking_available', text: 'sim')


  end
end