def register_type(name)
    fill_in 'property_type_name', with: name
    click_on 'commit'
end

describe 'Visitor visit homepage' do
    it 'clicks type register button, and successfully creates new property type' do
        #arrange

        #act
        visit root_path
        find("#type_register_link").click
        register_type('tipo_teste')
        corresponding_types = PropertyType.where(name: 'tipo_teste')

        #assert
        expect(corresponding_types.length).to eq 1
        expect(current_path).to eq root_path
    end

    it 'clicks type register button, and successfully creates new property type converted to lowercase' do
        #arrange

        #act
        visit root_path
        find("#type_register_link").click
        register_type('TIPO_teste')
        corresponding_types = PropertyType.where(name: 'tipo_teste')

        #assert
        expect(corresponding_types.length).to eq 1
        expect(current_path).to eq root_path
    end

    it 'clicks type register button, and show error when creating already existing property type' do
        #arrange
        PropertyType.create!(name: 'tipo_teste')

        #act
        visit root_path
        find("#type_register_link").click
        register_type('tipO_teste')

        #assert
        expect(page).to have_content('Já existe com esse nome')
    end

    it 'clicks register button, clicks type register button, and gets redirected to register page again' do
        #arrange

        #act
        visit root_path
        find("#register_link").click
        register_path = current_path
        find("#type_register_link").click
        register_type('tipo_teste')

        #assert
        expect(current_path).to eq register_path
    end

    it 'clicks type register button and goes back (to menu)' do
        visit root_path
        find("#type_register_link").click
        find(".back_button").click
    
        expect(current_path).to eq root_path
      end

    it 'clicks type register button and goes back (to register page)' do
        visit root_path
        find("#register_link").click
        register_path = current_path
        find("#type_register_link").click
        find(".back_button").click
    
        expect(current_path).to eq register_path
    end
end