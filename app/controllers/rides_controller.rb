class RidesController < ApplicationController
  load_and_authorize_resource

  def index
    @ride = Ride.new
    @ride.is_round_trip = true
  end

  def new
    @ride = Ride.new
    @ride.is_round_trip = true
  end

  def create
    if score_keeper.update(@ride) { @ride.save }
      flash[:success] = t("ride.add.success")
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if score_keeper.update(@ride) { @ride.update_attributes(ride_params) }
      flash[:success] = t("ride.edit.success")
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    score_keeper.update(@ride) { @ride.destroy }
    flash[:success] = t("ride.delete.success")
    redirect_to dashboard_path
  end

  private

  def ride_params
    params.require(:ride).permit(:date, :description, :bike_distance,
                                 :bus_distance, :walk_distance, :rider_id,
                                 :is_round_trip, :work_trip)
  end

  def score_keeper
    @score_keeper ||= ScoreKeeper.new(current_user)
  end
end
