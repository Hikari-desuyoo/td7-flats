class PropertiesController < ApplicationController
    def show
        @property = Property.find(params[:id])
    end

    def new
        @property = Property.new
    end

    def create
        @property = Property.new(property_hash)
        if @property.save
            redirect_to @property
        else
            render :new
        end
    end

    def edit
        @property = Property.find(params[:id])
    end

    def update
        @property = Property.find(params[:id])
        @property.update(property_hash)

        redirect_to @property
    end

    def property_hash
        params.require(:property).permit(
            :title, :description, :rooms, :bathrooms, :allow_pets, :parking_available, :daily_price
        )
    end
end