class HomeController < ApplicationController
    def index
        @filtered = false
        @properties = Property.all
        @property_types = PropertyType.all
       
    end

    def filter
        @filtered = true
        property_type_id = params[:property_type_filter]
        @property_type = PropertyType.find(property_type_id)

        @properties = @property_type.properties

        @property_types = PropertyType.all
        render :index
    end
end