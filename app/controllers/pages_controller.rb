class PagesController < ApplicationController
  before_action :set_hospital, only: [:doctor]
  before_action :set_doctor, only: [:doctor]

  def index
    @hospitals = Hospital.search(params[:keyword]) if params[:keyword].present?
  end

  def show
    @hospital = Hospital.includes(:doctors).find(params[:slug].to_i)
  end

  def doctor
    @booking = Booking.new
    @today = Date.today
    @days = (@today.beginning_of_week..@today.end_of_week).to_a
    @days = @days.map do |day|
      {
        schedules: @doctor.select_by(day),
        day: day
      }
    end
  end

  def my_bookings
    @bookings = Booking.includes(:doctor).where(user: current_user)
    render 'bookings/index'
  end

  private

  def set_hospital
    @hospital = Hospital.includes(:doctors).find(params[:hospital_slug].to_i)
  end

  def set_doctor
    @doctor = Doctor.includes(:schedules).find(params[:slug])
  end
end
