require 'spec_helper'

describe "Static pages" do

	let(:full_title) { "encouragebot" }

	describe "Home page" do
		before { visit root_path }

		it "should have the content 'Encourage Bot'" do
			page.should have_content('Encourage Bot')
		end

		it "should have the right title" do
			page.should have_selector("title", text: "#{full_title}")
		end

		it "should not have a custom page title" do
			page.should_not have_selector("title", text: "#{full_title} - home")
		end

	end

	describe "Help page" do
		before { visit help_path }

		it "should have the content 'Help'" do
			page.should have_content('Help')
		end

		it "should have the right title" do
			page.should have_selector("title", text: "#{full_title} - help")
		end

	end

	describe "About page" do
		before { visit about_path }

		it "should have the content 'About'" do
			page.should have_content('About')
		end

		it "should have the right title" do
			page.should have_selector("title", text: "#{full_title} - about")
		end

	end

	describe "Contact page" do
		before { visit contact_path }

		it "should have the content 'Contact" do
			page.should have_content('Contact')
		end

		it "should have the right title" do
			page.should have_selector('title', text: "#{full_title} - contact")
		end

	end

end
