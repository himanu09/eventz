class UsersController < ApplicationController
  
	before_action :require_signin, except: [:new, :create]

	before_action :require_currect_user, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
		@user  = User.find(params[:id])
		@registrations = @user.registrations
		@liked_events = @user.liked_events
	end

	def new
		@user  = User.new
	end

	def create
	  @user  = User.new(user_params)
	  if @user.save
	  	session[:user_id] = @user.id
      	redirect_to @user, notice: "Thanks for signing up!"
    else
			render :new, status: :unprocessable_entity
	  end
	end

	def edit
	end

	def update 
		if @user.update(user_params)
			redirect_to @user, notice: "Account successfully updated!"
		else
      render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		session[:user_id] = nil
		@user.destroy
		redirect_to users_url, status: :see_other, alert: "Account successfully deleted!"
	end

private

	def require_currect_user
		@user  = User.find(params[:id])
		redirect_to root_url, status: :see_other unless current_user?(@user)
	end

  def user_params
		params.require(:user).permit(:name, :email, :password,:profile_image, :password_confirmation)
	end


end
