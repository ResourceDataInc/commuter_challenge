class CompetitionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @competition.save
      flash[:success] = t("competition.add.success")
      redirect_to @competition
    else
      render :new
    end
  end

  def show
    @competition = Competition.includes(:brackets, teams: [:rides]).find(params[:id])
    calculator = ParticipationCalculator.new(@competition)
    team_participations = calculator.team_participations
    member_participations = calculator.member_participations
    @brackets = Hash[@competition.brackets.map { |bracket|
      range = bracket.lower_limit..bracket.upper_limit
      tps = team_participations.select { |tp| range.include?(tp.team.business_size) }
      mps = member_participations.select { |mp| range.include?(mp.team.business_size) }
      [
        bracket,
        {
          teams: tps.sort_by { |tp| -tp.participation_percent },
          members: mps.sort_by { |mp| -mp.participation_percent }.first(10)
        }
      ]
    }]
  end

  def edit
    @bracket = Bracket.new
  end

  def update
    if @competition.update_attributes(params[:competition])
      flash[:success] = t("competition.edit.success")
      redirect_to @competition
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @competition.destroy
    flash[:success] = t("competition.delete.success")
    redirect_to root_url
  end
end
