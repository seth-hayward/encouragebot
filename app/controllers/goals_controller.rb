class GoalsController < ApplicationController
	before_filter :signed_in_user

	def index
	end

	def hide
		@goal = current_user.goals.find_by_id(params[:id])
		@goal.update_attribute(:status, 0)
		flash[:success] = "The goal, #{@goal.title} was hidden."
		redirect_to root_path
	end

	def unhide
		@goal = current_user.goals.find_by_id(params[:id])
		@goal.update_attribute(:status, 1)
		flash[:success] = "The goal, #{@goal.title} is now visible."
		redirect_to root_path
	end

	def hidden
		@goals = current_user.goals.where("status = 0")
	end

	def show
		begin		
	  	@goal = current_user.goals.find(params[:id])
	  	@update = @goal.updates.new
	  rescue
	  	flash[:error] = "We couldn't find that goal."
	  	redirect_to root_path
	  end
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