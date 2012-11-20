class UpdatesController < ApplicationController
	before_filter :signed_in_user

	def create
		@goal = current_user.goals.find(params[:goal_id])
		@update = @goal.updates.build(params[:update])
		if @update.save
			flash[:success] = "Updated added! Great work, keep it up."
			redirect_to goal_path(@goal)
		else
			flash[:error] = "Sorry, there was an error adding your update."
			redirect_to goal_path(@goal)
		end
	end

	def destroy
		@fated_update = Update.find(params[:id])
		@goal = current_user.goals.find(@fated_update.goal_id)
		@fated_update.destroy
		redirect_to goal_path(@goal)
	end

end