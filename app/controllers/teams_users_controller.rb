class TeamsUsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  
  def update
    @teams_user = TeamsUser.find(params[:id])
    @teams_user.approved = !@teams_user.approved
    
    respond_to do |format|
      if @teams_user.save()
        format.html { redirect_to :back, notice: 'Approval successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, :flash => {:error=> 'Approval was not updated: ' + @teams_user.errors.inspect }}
        format.json { render json: @teams_user.errors, status: :unprocessable_entity }
      end
    end
  end
end