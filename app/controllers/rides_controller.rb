class RidesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @ride = Ride.new
    @ride.is_round_trip = true
  end

  def create
    if @ride.save
      flash[:success] = "Ride logged."
      redirect_to @ride
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ride.update_attributes(params[:ride])
      flash[:success] = "Ride updated."
      redirect_to @ride
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @ride.destroy
    flash[:success] = "Ride deleted."
    redirect_to rides_url
  end
end