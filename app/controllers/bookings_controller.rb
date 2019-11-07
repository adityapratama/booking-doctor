class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_doctor, only: [:create]
  before_action :authorized, only: [:create]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @booking = Booking.new
    @start_date = params[:start_date]
    @end_date = params[:end_date]
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @start_date = booking_params[:start_date]
    @end_date = booking_params[:end_date]
    @hospital = @doctor.hospital
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    respond_to do |format|
      if @booking.save
        notice = "Booking doctor #{@doctor.name} at #{@start_date.to_datetime.strftime('%d-%A-%Y')} #{@start_date.to_datetime.strftime('%H-%M')} until #{@end_date.to_datetime.strftime('%H-%M')} succeded"
        format.html { redirect_to "/hospitals/#{@hospital.slug}/doctors/#{@doctor.slug}", notice: notice}
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, locals: { start_date: @start_date, end_date: @end_date } }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_doctor
      @doctor = Doctor.find(booking_params[:doctor_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:doctor_id, :doctor_name, :start_date, :end_date)
    end
end
