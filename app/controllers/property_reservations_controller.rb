class PropertyReservationsController < ApplicationController
    def create
        @property_reservation = PropertyReservation.new(property_reservation_params)
        @property_reservation.property = Property.find(params[:property_id])
        @property_reservation.user = current_user
        @property_reservation.total_value = 1

        @property_reservation.save!

        redirect_to @property_reservation, notice: 'Criado com sucesso'
    end

    def show
        @property_reservation = PropertyReservation.find(:id)
    end

    private
    def property_reservation_params
        params.require(:property_reservation).permit(:start_date, :end_date, :guests)
    end
end