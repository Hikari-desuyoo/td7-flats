class PropertyType < ApplicationRecord
    validates :name, uniqueness: true

    has_many :properties
end
