class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

	def load_readme()

		text = IO.read("README.markdown")
		options = [:hard_wrap => true]
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :hard_wrap => true)
		return markdown.render(text).html_safe

	end	

end
