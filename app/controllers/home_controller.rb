class HomeController < ApplicationController
    def index
        @filtered = false
        @properties = Property.all
        
        @selected_property_type_id = -1

        @property_types_selection_list = property_types_selection_list
       
    end

    def filter
        @filtered = true

        @selected_property_type_id = params[:property_type_filter].to_i

        unless @selected_property_type_id == -1
            selected_property_type = PropertyType.find(@selected_property_type_id)
            @properties = selected_property_type.properties
        else
            @properties = Property.all
        end
        

        @property_types_selection_list = property_types_selection_list

        render :index
    end

    def property_types_selection_list
        property_types = PropertyType.all
        selection_list = property_types.map {|p_type| [p_type.name, p_type.id]}
        selection_list = [['QUALQUER UM', -1]] + selection_list
        selection_list
    end 

end