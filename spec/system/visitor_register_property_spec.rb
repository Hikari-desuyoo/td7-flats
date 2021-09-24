require 'rails_helper'

def sim_nao(boolean)
    boolean ? "sim" : "não"
  end

describe 'Visitor visit homepage, clicks register' do
  it 'and successfully registers a property' do
    visit root_path
    find("#register_link").click
    fill_in 'property_title', with: 'titulo1'
    fill_in 'property_description', with: 'descrição1'
    fill_in 'property_rooms', with: '3'
    fill_in 'property_bathrooms', with: '2'
    fill_in 'property_daily_price', with: 200
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

  end

  it 'and goes back to menu' do
    visit root_path
    find("#register_link").click
    find(".back_button").click

    expect(current_path).to eq root_path
  end
end