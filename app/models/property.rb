class Property < ApplicationRecord
    belongs_to :property_type
    
    validates :title, :description, :rooms, :bathrooms, :daily_price,
              presence: { message: 'Obrigatório preencher' }

    validates :rooms, :bathrooms, numericality: { only_integer: true, message: 'Necessário ser um número' }
    validates :daily_price, numericality: { message: 'Necessário ser um número' }
end
