require 'spec_helper'

describe "Static pages" do

	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector("h1", text: heading) }
		it { should have_selector("title", text: full_title(page_title)) }		
	end

	describe "Home page" do
		before { visit root_path }
		let(:heading) { 'Encourage Bot' }
		let(:page_title) { '' }

		it { should_not have_selector("title", text: full_title('home')) }
		it_should_behave_like "all static pages"
	end

	describe "Help page" do
		before { visit help_path }
		let(:heading) { 'Help' }
		let(:page_title) { 'help' }
		it_should_behave_like "all static pages"
	end

	describe "About page" do
		before { visit about_path }
		let(:heading) { 'encourage bot' }
		let(:page_title) { 'about' }
		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before { visit contact_path }
		let(:heading) { 'Contact' }
		let(:page_title) { 'contact' }
		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		page.should have_selector 'title', text: full_title('about')
		click_link "Help"
		page.should have_selector 'title', text: full_title('help')
		click_link "Contact"
		page.should have_selector 'title', text: full_title('contact')
		click_link "Home"
		click_link "Try it, free!"
		page.should have_selector 'title', text: full_title('sign up')
		click_link "encourage bot"
		page.should have_selector 'title', text: full_title('')
	end

end
