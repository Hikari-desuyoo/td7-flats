require 'rails_helper'

describe 'Visitor log in' do
  context 'as property owner' do 
    it 'and logs in' do
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: property_owner.email
        fill_in 'Senha', with: property_owner.password
        click_on 'commit'

        expect(page).to have_content('Login efetuado com sucesso!')
        expect(page).to have_content(property_owner.email)
        expect(page).to have_link('Logout')
        expect(page).not_to have_link('Entrar')
        expect(page).to have_css('#register_link')
    end

    it 'and logs out' do
      property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

      login_as property_owner, scope: :property_owner

      visit root_path

      click_on 'Logout'
      expect(page).to have_content('Saiu com sucesso.')
      expect(page).to_not have_link('Logout')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_css('#register_link')

    end

    it 'and registers' do
      
    end
  end
end