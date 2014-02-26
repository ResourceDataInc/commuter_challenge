class BracketsController < ApplicationController
  load_and_authorize_resource :competition
  load_and_authorize_resource through: :competition

  def create
    @bracket = @competition.brackets.build(bracket_params)
    if @bracket.save
      flash[:success] = t("bracket.add.success")
      redirect_to edit_competition_url(@competition)
    else
      render :new
    end
  end

  def update
    if @bracket.update_attributes(bracket_params)
      flash[:success] = t("bracket.edit.success")
      redirect_to edit_competition_url(@competition)
    else
      render :edit
    end
  end

  def destroy
    @bracket = @competition.brackets.find(params[:id])
    @bracket.destroy
    flash[:success] = t("bracket.delete.success")
    redirect_to edit_competition_url(@competition)
  end

  private

  def bracket_params
    params.require(:bracket).permit(:competition_id, :lower_limit, :name, :upper_limit)
  end
end
