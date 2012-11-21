class StaticPagesController < ApplicationController

  def home
  end

  def help
  end

  def about
    @readme = load_readme
  end

  def contact
  end

end
