require 'spec_helper'

describe "Static pages" do

	let(:full_title) { "encouragebot" }

	describe "Home page" do

		it "should have the content 'Encourage Bot'" do
			visit '/static_pages/home'
			page.should have_content('Encourage Bot')
		end

		it "should have the right title" do
			visit '/static_pages/home'
			page.should have_selector("title", text: "#{full_title}")
		end

		it "should not have a custom page title" do
			visit '/static_pages/home'
			page.should_not have_selector("title", text: "#{full_title} - home")
		end

	end

	describe "Help page" do

		it "should have the content 'Help'" do
			visit '/static_pages/help'
			page.should have_content('Help')
		end

		it "should have the right title" do
			visit '/static_pages/help'
			page.should have_selector("title", text: "#{full_title} - help")
		end

	end

	describe "About page" do

		it "should have the content 'About'" do
			visit '/static_pages/about'
			page.should have_content('About')
		end

		it "should have the right title" do
			visit '/static_pages/about'
			page.should have_selector("title", text: "#{full_title} - about")
		end

	end

	describe "Contact page" do

		it "should have the content 'Contact" do
			visit '/static_pages/contact'
			page.should have_content('Contact')
		end

		it "should have the right title" do
			visit '/static_pages/contact'
			page.should have_selector('title', text: "#{full_title} - contact")
		end

	end

end
