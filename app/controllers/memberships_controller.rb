class MembershipsController < ApplicationController
  load_and_authorize_resource :team
  load_and_authorize_resource through: :team

  def create
    if @membership.save
      flash[:success] = t("team.join.request_confirmation")
    else
      flash[:alert] = t("team.join.request_already_member")
    end
    redirect_to @team
  end

  def update
    if @membership.update_attributes(params[:membership])
      flash[:success] = t("team.join.approve_confirmation")
    else
      flash[:error] = t("team.join.approve_failure")
    end
    redirect_to @team
  end

  def delete
  end

  def destroy
    @membership.destroy
    flash[:success] = t("membership.delete.success")
    redirect_to @team
  end
end
