require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully sees existing properties' do
    Property.create({ 
      title: 'titulo1', 
      description: 'descrição1',
      rooms: 3, 
      parking_available: true
    })

    Property.create({ 
      title: 'titulo2', 
      description: 'descrição2',
      rooms: 20, 
      parking_available: false
    })

    visit root_path

    expect(page).to have_css('id#property-0', text: 'titulo1')
    expect(page).to have_css('id#property-0', text: 'descrição1')
    expect(page).to have_css('id#property-0', text: '3')
    expect(page).to have_css('id#property-0', text: 'sim')

    expect(page).to have_css('id#property-1', text: 'titulo2')
    expect(page).to have_css('id#property-1', text: 'descrição2')
    expect(page).to have_css('id#property-1', text: '20')
    expect(page).to have_css('id#property-1', text: 'não')

  end
end