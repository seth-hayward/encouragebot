require 'spec_helper'

describe "Static pages" do

	let(:full_title) { "encouragebot" }

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_content('Encourage Bot') }
		it { should have_selector("title", text: "#{full_title}") }
		it { should_not have_selector("title", text: "#{full_title} - home") }
	end

	describe "Help page" do
		before { visit help_path }

		it { should have_content('Help') }
		it { should have_selector("title", text: "#{full_title} - help") }
	end

	describe "About page" do
		before { visit about_path }

		it { should have_content('About') }
		it { should have_selector("title", text: "#{full_title} - about") }
	end

	describe "Contact page" do
		before { visit contact_path }

		it { should have_content('Contact') }
		it { should have_selector('title', text: "#{full_title} - contact") }
	end

end
