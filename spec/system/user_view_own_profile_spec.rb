require 'rails_helper'

describe 'User view own profile from menu' do
    it 'successfully' do
        user = User.create!(email: 'bob@example.com', password: '123456')

        login_as user, scope: :user
        visit root_path
        click_on 'Meu perfil'

        expect(page).to have_content 'Meu perfil'
        expect(page).to have_content 'bob@example.com'
        expect(current_path).to eq my_profile_path
    end
end