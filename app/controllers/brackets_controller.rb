class BracketsController < ApplicationController
  load_and_authorize_resource :competition
  load_and_authorize_resource through: :competition

  def create
    @bracket = @competition.brackets.build(params[:bracket])
    if @bracket.save
      flash[:success] = "Category added."
      redirect_to edit_competition_url(@competition)
    else
      render :new
    end
  end

  def update
    if @bracket.update_attributes(params[:bracket])
      flash[:success] = "Category updated."
      redirect_to edit_competition_url(@competition)
    else
      render :edit
    end
  end

  def destroy
    @bracket = @competition.brackets.find(params[:id])
    @bracket.destroy
    flash[:success] = "Category removed."
    redirect_to edit_competition_url(@competition)
  end
end