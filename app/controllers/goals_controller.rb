class GoalsController < ApplicationController
	before_filter :signed_in_user

	def index
	end

	def show
		@goal = current_user.goals.first
	end

	def new
		@goal = current_user.goals.build if signed_in?
	end

	def create
		@goal = current_user.goals.build(params[:goal])
		if @goal.save
			flash[:success] = "Goal created! Great work."
			redirect_to root_path
		else
			render 'new'
		end
	end

	def destroy
	end

	def edit
	end

	def update
	end	

end