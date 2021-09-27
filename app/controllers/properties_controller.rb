class PropertiesController < ApplicationController
    def show
        @property = Property.find(params[:id])
    end

    def new
        @property = Property.new
        @property_types = PropertyType.all
    end

    def create
        @property = Property.new(property_hash)
        @property_types = PropertyType.all
        if @property.save
            redirect_to @property
        else
            render :new
        end
    end

    def edit
        @property_types = PropertyType.all
        @property = Property.find(params[:id])
    end

    def update
        @property = Property.find(params[:id])
        @property.update(property_hash)

        redirect_to @property
    end

    def property_hash
        property_type = PropertyType.find(params.require(:property)[:property_type_id])

        hash = params.require(:property).permit(
            :title, :description, :rooms, 
            :bathrooms, :allow_pets, :parking_available, 
            :daily_price
        )

        hash[:property_type] = property_type
        hash
    end
end