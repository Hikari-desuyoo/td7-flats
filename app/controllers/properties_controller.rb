class PropertiesController < ApplicationController
    def show
        @property = Property.find(params[:id])
    end

    def new
        @property = Property.new
    end

    def create
        property_hash = params.require(:property).permit(
            :title, :description, :rooms, :bathrooms, :allow_pets, :parking_available, :daily_price
        )
        property = Property.create(property_hash)
        redirect_to property
    end

    def edit
        @property = Property.find(params[:id])
    end

    def update
        @property = Property.find(params[:id])
        property_hash = params.require(:property).permit(
            :title, :description, :rooms, :bathrooms, :allow_pets, :parking_available, :daily_price
        )
        @property.update(property_hash)

        redirect_to @property
    end
end