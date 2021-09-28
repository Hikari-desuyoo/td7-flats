class PropertyLocationsController < ApplicationController
    def new
        @property_location = PropertyLocation.new
        flash[:previous_page] = "#{request.referer}"
    end

    def create
        @property_location = PropertyLocation.new(property_location_hash)

        if @property_location.save
            redirect_to flash[:previous_page]
        else
            render :new
        end
    end

    def property_location_hash
        hash = params.require(:property_location).permit(:name)
        hash[:name] = hash[:name].upcase 
        hash
    end
end