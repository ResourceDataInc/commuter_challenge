class CompetitionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @competition.save
      flash[:success] = "Competition created"
      redirect_to @competition
    else
      render :new
    end
  end

  def show
  end

  def edit
    @bracket = Bracket.new
  end

  def update
    if @competition.update_attributes(params[:competition])
      flash[:success] = "Competition updated"
      redirect_to @competition
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @competition.destroy
    flash[:success] = "Competition deleted"
    redirect_to root_url
  end
end
