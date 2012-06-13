class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(params[:user])
    @user.add_role :cyclist
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end
end