require 'rails_helper'

RSpec.describe Property, type: :model do
    context 'validations' do
        context 'present' do
            subject do
                property = Property.new
                property.valid?
                property.errors
            end
            
          it 'title must be present' do
            expect(
                subject.full_messages_for(:title)
            ).to include('Título não pode ficar em branco')
          end
    
          it 'description must be present' do
            expect(
                subject.full_messages_for(:description)
            ).to include('Descrição não pode ficar em branco')
          end
            
          it 'description must be present' do
            expect(
                subject.full_messages_for(:rooms)
            ).to include('Número de quartos não pode ficar em branco')
          end

          it 'description must be present' do
            expect(
                subject.full_messages_for(:bathrooms)
            ).to include('Número de banheiros não pode ficar em branco')
          end

          it 'description must be present' do
            expect(
                subject.full_messages_for(:daily_price)
            ).to include('Preço da diária não pode ficar em branco')
          end
        end
      end
end
