class StaticPagesController < ApplicationController

  def home
  	if signed_in? == true
	  	@user = current_user
	  	@goals = @user.goals.paginate(page: params[:page])
  	end
  end

  def help
    @readme = load_readme
  end

  def about
  end

  def contact
  end

end
