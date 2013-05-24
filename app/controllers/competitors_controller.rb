class CompetitorsController < ApplicationController
  load_and_authorize_resource :competition
  load_and_authorize_resource through: :competition

  def create
    if @competitor.save
      flash[:success] = t("competition.join.request_confirmation")
    else
      flash[:alert] = t("competition.join.request_already_member")
    end
    redirect_to edit_competition_path @competitor.competition
  end

  def update
    if @competitor.update_attributes(params[:competitor])
      flash[:success] = t("competition.join.approve_confirmation")
    else
      flash[:error] = t("competition.join.approve_failure")
    end
    redirect_to edit_competition_path @competitor.competition
  end

  def delete
  end

  def destroy
    @competitor.destroy
    flash[:success] = t("competitor.delete.success")
    redirect_to edit_competition_path @competitor.competition
  end
end
