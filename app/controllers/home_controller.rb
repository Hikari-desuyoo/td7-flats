class HomeController < ApplicationController
    def index
        @filtered = false
        @properties = Property.all
        
        @selected_property_type_id = -1
        @selected_property_location_id = -1

        @property_types_selection_list = selection_list PropertyType.all
        @property_locations_selection_list = selection_list PropertyLocation.all
       
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

        @property_types_selection_list = selection_list PropertyType.all
        @property_locations_selection_list = selection_list PropertyLocation.all

        render :index
    end

    def selection_list(model_all)
        selection_list = model_all.map {|model_obj| [model_obj.name, model_obj.id]}
        selection_list = [['QUALQUER UM', -1]] + selection_list
        selection_list
    end 



end