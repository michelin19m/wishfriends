class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    if @item.single_booking? && @item.bookings.exists?(status: 'booked')
      render json: { error: 'This item has already been booked.' }, status: :unprocessable_entity
    else
      @booking = @item.bookings.build(user: current_user, status: 'booked')
      if @booking.save
        NotificationJob.perform_later(current_user.id, "You have booked an item: #{@item.name}")
        render json: @booking, status: :created
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end
  end

  def index
    @bookings = current_user.bookings
    render json: @bookings
  end

  def destroy
    @booking = current_user.bookings.find(params[:id])
    @booking.update(status: 'canceled')
    head :no_content
  end
end
