class Property < ApplicationRecord
    validates :title, :description, :rooms, :bathrooms, :daily_price,
              presence: { message: 'Obrigatório preencher' }
end
