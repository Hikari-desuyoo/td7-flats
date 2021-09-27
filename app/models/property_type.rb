class PropertyType < ApplicationRecord
    validates :name, uniqueness: { message: 'Já existe com esse nome' }

    has_many :properties
end
