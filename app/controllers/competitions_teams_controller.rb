class CompetitionsTeamsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  skip_authorize_resource :only => [:index, :show]
  
  def index
    render json: params
  end
  
  def new
    @competition = Competition.find(params[:competition_id])    
    @competition_team = CompetitionsTeam.new
    @teams = current_user.teams.select{|t| !t.competitions.include? @competition}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition }
    end
  end
  
  def create
    @competition = Competition.find(params[:competition_id])
    @team = Team.find(params[:competitions_team][:team_id])
    @competition.teams << @team
    @teams = current_user.teams.select{|t| !t.competitions.include? @competition}

    respond_to do |format|
      if @competition.save
        format.html { redirect_to competitions_path, notice: 'Successfully joined competition.' }
      else
        format.html { render action: "index" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete
    @competition = Competition.find(params[:competition_id])
    @competition_team = CompetitionsTeam.new
    @teams = current_user.teams.select{|t| t.competitions.include? @competition}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition }
    end
  end
  
  def remove
    @competition = Competition.find(params[:competition_id])
    @team = Team.find(params[:competitions_team][:team_id])
    @competition.teams.delete(@team)
    @teams = current_user.teams.select{|t| t.competitions.include? @competition}
    respond_to do |format|
      if @competition.save
        format.html { redirect_to competitions_path, notice: 'Successfully left competition.' }
      else
        format.html { render action: "index" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end
end