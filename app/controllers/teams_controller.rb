class TeamsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @team.save
      flash[:success] = "Team created"
      redirect_to @team
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @team.update_attributes(params[:team])
      flash[:success] = "Team updated"
      redirect_to @team
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @team.destroy
    flash[:success] = "Team deleted"
    redirect_to root_url
  end
end