class StaticPagesController < ApplicationController

  def home
  end

  def help
    @readme = load_readme
  end

  def about
  end

  def contact
  end

end
