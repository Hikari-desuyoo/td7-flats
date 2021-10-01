class Property < ApplicationRecord
    belongs_to :property_type
    belongs_to :property_location
    
    validates :title, :description, :rooms, :bathrooms, :daily_price,
              presence: true

    validates :bathrooms, numericality: { only_integer: true }
    validates :rooms, numericality: { only_integer: true }
    validates :daily_price, numericality: true
end
