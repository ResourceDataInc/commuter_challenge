class TeamsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  def index
    @teams = Team.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  def join
    @team = Team.find(params[:id])
    @team.cyclists << current_user
    
    respond_to do |format|
      if @team.save
        format.html { redirect_to root_path, notice: 'Successfully joined team.' }
        format.json { render json: @team, status: :joined, location: @team }
      else
        format.html { render action: "index" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  def leave
    @team = Team.find(params[:id])
    @team.cyclists.delete(current_user)
    
    respond_to do |format|
      if @team.save
        format.html { redirect_to root_path, notice: 'Successfully left team.' }
        format.json { render json: @team, status: :joined, location: @team }
      else
        format.html { render action: "index" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new
    @team = Team.new
    @team.captain = current_user
    @team.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

 def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
