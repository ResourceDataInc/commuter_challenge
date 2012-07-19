class RidesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  skip_authorize_resource :only => [:index, :show]
  
  def index
    @rides = Ride.order(sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rides }
    end
  end

  def show
    @ride = Ride.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ride }
    end
  end

  def new
    @ride = Ride.new
    @ride.date = Time.now

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ride }
    end
  end

  def edit
    @ride = Ride.find(params[:id])
  end

  def create
    @ride = Ride.new(params[:ride])   
    @ride.user = current_user
    
    respond_to do |format|
      if @ride.save
        format.html { redirect_to @ride, notice: 'Ride was successfully created.' }
        format.json { render json: @ride, status: :created, location: @ride }
      else
        format.html { render action: "new" }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ride = Ride.find(params[:id])
    
    respond_to do |format|
      if @ride.update_attributes(params[:ride])
        format.html { redirect_to @ride, notice: 'Ride was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy

    respond_to do |format|
      format.html { redirect_to rides_url }
      format.json { head :no_content }
    end
  end
  
  private 
  def sort_column
    Ride.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
