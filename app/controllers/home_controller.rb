class HomeController < ApplicationController
    def index
        @filtered = false
        @properties = Property.all
        
        @selected_property_type_id = -1
        @selected_property_location_id = -1

        @property_types_selection_list = property_types_selection_list
        @property_locations_selection_list = property_locations_selection_list
       
    end

    def filter
        @filtered = true

        @selected_property_type_id = params[:property_type_filter].to_i
        @selected_property_location_id = params[:property_location_filter].to_i


        @properties = Property.all

        unless @selected_property_type_id == -1
            @properties = @properties.where(
                property_type: PropertyType.find(@selected_property_type_id)
            )
        end

        unless @selected_property_location_id == -1
            @properties = @properties.where(
                property_location: PropertyLocation.find(@selected_property_location_id)
            )
        end
        

        @property_types_selection_list = property_types_selection_list
        @property_locations_selection_list = property_locations_selection_list


        render :index
    end

    def property_types_selection_list
        all = PropertyType.all
        selection_list = all.map {|model_obj| [model_obj.name, model_obj.id]}
        selection_list = [['QUALQUER UM', -1]] + selection_list
        selection_list
    end 

    def property_locations_selection_list
        all = PropertyLocation.all
        selection_list = all.map {|model_obj| [model_obj.name, model_obj.id]}
        selection_list = [['QUALQUER UM', -1]] + selection_list
        selection_list
    end 



end