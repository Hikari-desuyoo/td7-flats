require 'rails_helper'

def sim_nao(boolean)
    boolean ? "sim" : "não"
  end

describe 'Visitor visit homepage, clicks register' do
  it 'and successfully registers a property' do
    PropertyType.create!(name: 'casa')

    visit root_path
    find("#register_link").click
    fill_in 'property_title', with: 'titulo1'
    fill_in 'property_description', with: 'descrição1'
    fill_in 'property_rooms', with: '3'
    fill_in 'property_bathrooms', with: '2'
    fill_in 'property_daily_price', with: 200
    select 'casa', from: 'property_property_type_id'
    check 'property_allow_pets'
    check 'property_parking_available'
    click_on 'commit'

    css_beginning = "div#information ."
    expect(page).to have_css(css_beginning + 'title', text: 'titulo1')
    expect(page).to have_css(css_beginning + 'description', text: 'descrição1')
    expect(page).to have_css(css_beginning + 'rooms', text: '3')
    expect(page).to have_css(css_beginning + 'bathrooms', text: '2')
    expect(page).to have_css(css_beginning + 'allow_pets', text: 'sim')
    expect(page).to have_css(css_beginning + 'daily_price', text: '200')
    expect(page).to have_css(css_beginning + 'parking_available', text: 'sim')
    expect(page).to have_css(css_beginning + 'property_type', text: 'Casa')

  end

  it 'and fills in nothing and get error messages' do
    PropertyType.create!(name: 'casa')
    
    visit root_path
    find("#register_link").click
    click_on 'commit'


    expect(page).to have_content('Obrigatório preencher', count: 5)
  end

  it 'and fills in text into integer fields and get error messages' do
    PropertyType.create!(name: 'casa')
    
    visit root_path
    find("#register_link").click
    fill_in 'property_title', with: 'titulo1'
    fill_in 'property_description', with: 'descrição1'
    select 'casa', from: 'property_property_type_id'
    check 'property_allow_pets'
    check 'property_parking_available'

    fill_in 'property_rooms', with: 'a'
    fill_in 'property_bathrooms', with: 5.2
    fill_in 'property_daily_price', with: 'c'
    click_on 'commit'

    expect(page).to have_content('Necessário ser um número', count: 3)
  end

  it 'and goes back to menu' do
    visit root_path
    find("#register_link").click
    find(".back_button").click

    expect(current_path).to eq root_path
  end
end