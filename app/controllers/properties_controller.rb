class PropertiesController < ApplicationController
    before_action :authenticate_property_owner!, only: [:new, :create]

    def show
        @property = Property.find(params[:id])
        @property_reservation = PropertyReservation.new
    end

    def new
        @property = Property.new
        @property_types = PropertyType.all
        @property_locations = PropertyLocation.all
    end

    def create
        @property = Property.new(property_hash)
        @property.property_owner = current_property_owner
        @property_types = PropertyType.all
        @property_locations = PropertyLocation.all
        if @property.save
            redirect_to @property
        else
            render :new
        end
    end

    def edit
        @property_types = PropertyType.all
        @property_locations = PropertyLocation.all
        @property = Property.find(params[:id])
    end

    def update
        @property = Property.find(params[:id])
        @property.update(property_hash)

        redirect_to @property
    end

    def my_properties
        @properties = current_property_owner.properties
    end

    private

    def property_hash
        params.require(:property).permit(
            :title, :description, :rooms, 
            :bathrooms, :allow_pets, :parking_available, 
            :daily_price, :property_type_id, :property_location_id
        ) 
    end
end