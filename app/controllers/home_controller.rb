class HomeController < ApplicationController
    def index
        @filtered = false
        @properties = Property.all
        
        @selected_property_type_id = -1

        property_types = PropertyType.all
        @property_types_selection_list = property_types.map {|p_type| [p_type.name, p_type.id]}
       
    end

    def filter
        @filtered = true

        selected_property_type = PropertyType.find(params[:property_type_filter])
        @selected_property_type_id = selected_property_type.id

        @properties = selected_property_type.properties

        property_types = PropertyType.all
        @property_types_selection_list = property_types.map {|p_type| [p_type.name, p_type.id]}

        render :index
    end
end