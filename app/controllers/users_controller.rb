class UsersController < ApplicationController

	before_filter :signed_in_user, only: [:index, :edit, :update]
	before_filter :signed_in_user_disallowed, only: [:create, :new]
	before_filter :correct_user, only: [:show, :edit, :update]
	before_filter :admin_user, only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

  def show
  	if !signed_in?
  		render 'static_pages/home'
  		return
  	end
		@user = current_user
  	@goals = @user.goals.where("status = 1").paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

	def create
		@user = User.new(params[:user])
		if @user.save
	  	UserMailer.welcome_email(@user).deliver
			sign_in @user
			flash[:success] = "Welcome to Encourage Bot!"			
			redirect_to @user
		else
			render 'new'
		end
	end	 

	def edit
		@user = User.find_by_id(params[:id])
	end 

	def update
		@user = User.find_by_id(params[:id])
		if @user.update_attributes(params[:user])
			#success
			flash[:success] = "Profile updated!"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		user = User.find_by_id(params[:id])
		if user == current_user
			redirect_to root_path
			return
		else
			user.destroy
			flash[:success] = "User destroyed."
			redirect_to users_path
		end
	end

	private

		def signed_in_user_disallowed
			if signed_in?
				redirect_to root_path, notice: "You already have an account."
			end
		end

end
