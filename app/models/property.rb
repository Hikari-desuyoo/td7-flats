class Property < ApplicationRecord
    belongs_to :property_type
    
    validates :title, :description, :rooms, :bathrooms, :daily_price,
              presence: { message: 'Obrigatório preencher' }
end
