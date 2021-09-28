class HomeController < ApplicationController
    def index
        @filtered = false
        @properties = Property.all
        @property_types = PropertyType.all
        @selected_property_type = nil
       
    end

    def filter
        @filtered = true
        property_type_id = params[:property_type_filter]
        @selected_property_type = PropertyType.find(property_type_id)

        @properties = @selected_property_type.properties

        @property_types = PropertyType.all
        render :index
    end
end