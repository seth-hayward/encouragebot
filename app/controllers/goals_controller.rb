class GoalsController < ApplicationController
	before_filter :signed_in_user

	def index
	end

	def new
	end

	def create
		@goal = current_user.goals.build(params[:goal])
		if @goal.save
			flash[:success] = "Goal created! Great work."
			redirect_to root_path
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

	def edit
	end

	def update
	end	

end