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

		begin
			@goal = current_user.goals.find(@fated_update.goal_id)
			@fated_update.destroy
			redirect_to goal_path(@goal)
		rescue
			flash[:error] = "You do not have access to that update."
			redirect_to root_path
		end

	end

	def edit
		@update = Update.find(params[:id])
		begin
			@goal = current_user.goals.find_by_id(@update.goal_id)
		rescue
			flash[:error] = "You do not have access to that update."
			redirect_to root_path
		end
	end

	def update
		@update = Update.find_by_id(params[:id])

		begin

			@goal = current_user.goals.find_by_id(@update.goal_id)
			if @update.update_attributes(params[:update])
				#success
				flash[:success] = "Update updated!"
				redirect_to @goal
			else
				render 'edit'
			end

		rescue

			flash[:error] = "There was an error updating this update."
			redirect_to root_path
			
		end

	end

end