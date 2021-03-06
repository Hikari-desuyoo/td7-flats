class PropertyReservation < ApplicationRecord
  belongs_to :property
  belongs_to :user

  before_save :calculate_total_value

  validate :end_date_greater_than_start_date
  validate :start_date_in_the_future

  private

  def calculate_total_value
    self.total_value = (end_date - start_date).to_i * property.daily_price
  end

  def end_date_greater_than_start_date
    if start_date >= end_date
      errors.add(:end_date, 'deve ser maior que a data inicio ')
    end
  end

  def start_date_in_the_future
    if start_date < Date.today
      errors.add(:start_date, 'não pode ser no futuro')
    end
  end
end
