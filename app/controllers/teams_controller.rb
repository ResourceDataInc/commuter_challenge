class TeamsController < ApplicationController
  load_and_authorize_resource

  def index
    @teams = current_competition.teams.by_name
  end

  def new
  end

  def create
    @team.memberships.build(user: current_user, approved: true)

    if @team.save
      join_first_competition(@team)
      flash[:success] = t("team.add.success") 
      redirect_to @team
    else
      render :new
    end
  end

  def show
    @memberships = @team.memberships.by_username
    @membership = Membership.new
    @calculator = ParticipationCalculator.new(@team.competition)
  end

  def edit
  end

  def update
    if @team.update_attributes(team_params)
      flash[:success] = t("team.edit.success") 
      redirect_to @team
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @team.destroy
    flash[:success] = t("team.delete.success") 
    redirect_to root_url
  end

  private

  def join_first_competition(team)
    competition = current_competition
    unless competition.nil?
      competition.competitors.create(team_id: team.id, approved: true)
    end
  end

  def team_params
    params.require(:team).permit(:captain_id, :description, :name, :business_size)
  end
end
