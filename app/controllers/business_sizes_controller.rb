class BusinessSizesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  skip_authorize_resource :only => [:index, :show]

  def new
    @business_size = BusinessSize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_size }
    end
  end

  def edit
    @business_size = BusinessSize.find(params[:id])
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @business_size = @competition.business_sizes.new(params[:business_size])

    respond_to do |format|
      if @business_size.save
        format.html { redirect_to competition_path @competition, notice: 'Business size was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @business_size.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @competition = Competition.find(params[:competition_id])
    @business_size = BusinessSize.find(params[:id])

    respond_to do |format|
      if @business_size.update_attributes(params[:business_size])
        format.html { redirect_to @business_size, notice: 'Business size was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business_size.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @business_size = @competition.business_sizes.find(params[:id])
    @business_size.destroy

    respond_to do |format|
      format.html { redirect_to competition_path @competition }
      format.json { head :no_content }
    end
  end
end
