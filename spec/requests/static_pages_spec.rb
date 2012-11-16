require 'spec_helper'

describe "Static pages" do

	let(:full_title) { "encouragebot" }

	describe "Home page" do

		it "should have the content 'Encourage Bot'" do
			visit root_path
			page.should have_content('Encourage Bot')
		end

		it "should have the right title" do
			visit root_path
			page.should have_selector("title", text: "#{full_title}")
		end

		it "should not have a custom page title" do
			visit root_path
			page.should_not have_selector("title", text: "#{full_title} - home")
		end

	end

	describe "Help page" do

		it "should have the content 'Help'" do
			visit help_path
			page.should have_content('Help')
		end

		it "should have the right title" do
			visit help_path
			page.should have_selector("title", text: "#{full_title} - help")
		end

	end

	describe "About page" do

		it "should have the content 'About'" do
			visit about_path
			page.should have_content('About')
		end

		it "should have the right title" do
			visit about_path
			page.should have_selector("title", text: "#{full_title} - about")
		end

	end

	describe "Contact page" do

		it "should have the content 'Contact" do
			visit contact_path
			page.should have_content('Contact')
		end

		it "should have the right title" do
			visit contact_path
			page.should have_selector('title', text: "#{full_title} - contact")
		end

	end

end
