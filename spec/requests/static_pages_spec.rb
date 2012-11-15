require 'spec_helper'

describe "Static pages" do

	describe "Home page" do

		it "should have the content 'Encourage Bot'" do
			visit '/static_pages/home'
			page.should have_content('Encourage Bot')
		end

	end

end
