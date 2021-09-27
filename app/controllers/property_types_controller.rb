class PropertyTypesController < ApplicationController
    def new
        @property_type = PropertyType.new
        flash[:previous_page] = "#{request.referer}"
    end

    def create
        @property_type = PropertyType.new(property_type_hash)

        if @property_type.save
            redirect_to flash[:previous_page]
        else
            render :new
        end
    end

    def property_type_hash
        hash = params.require(:property_type).permit(:name)
        hash[:name] = hash[:name].downcase 
        hash
    end
end