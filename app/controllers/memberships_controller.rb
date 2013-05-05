class MembershipsController < ApplicationController
  load_and_authorize_resource :team
  load_and_authorize_resource through: :team

  def create
    if @membership.save
      flash[:success] = I18n.t("team.join.request_confirmation")
    else
      flash[:alert] = I18n.t("team.join.request_already_member")
    end
    redirect_to @team
  end
end
