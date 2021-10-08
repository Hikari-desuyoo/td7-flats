require 'rails_helper'

RSpec.describe PropertyReservation, type: :model do

    describe '#valid?' do
        before(:each) do
            property_type = PropertyType.create!(name: 'tipo')
            property_location = PropertyLocation.create!(name: 'local')
            property_owner = PropertyOwner.create!(email: 'nome@mail.com', password:'123456')
            @property = Property.create!(
                title:'titulo', 
                description: 'descricao',
                rooms: 2, bathrooms: 3, allow_pets: true, 
                parking_available: false,
                daily_price: 200,
                property_type: property_type,
                property_location: property_location,
                property_owner: property_owner
            )
        
            @user = User.create!(email: 'nome@mail.com', password:'123456')
    
        end

        it 'end date greater than start date' do 
            reservation = PropertyReservation.new(
                start_date: 5.days.from_now,
                end_date: 2.days.from_now,
                guests: 2,
                property: @property,
                user: @user
        
            )
            expect(reservation.valid?).to eq false
        end

        it 'end date equal to start date' do 
            base_date = 5.days.from_now
            reservation = PropertyReservation.new(
                start_date: base_date,
                end_date: base_date,
                guests: 2,
                property: @property,
                user: @user
        
            )
            
            expect(reservation.valid?).to eq false
        end

        it 'start date cant be in the past' do 
            reservation = PropertyReservation.new(
                start_date: 8.days.ago,
                end_date: 5.days.ago,
                guests: 2,
                property: @property,
                user: @user
        
            )

            expect(reservation.valid?).to eq false
        end
    end
end
