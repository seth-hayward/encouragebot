require 'spec_helper'

describe "User pages" do

	subject { page }

	shared_examples_for "all user pages" do
		it { should have_selector("h1", text: heading) }
		it { should have_selector("title", text: full_title(page_title)) }		
	end

	describe "signup page" do
		before { visit signup_path }
		let(:heading) { 'Sign up' }
		let(:page_title) { 'sign up' }
		it_should_behave_like "all user pages"
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		let(:heading) { user.name }
		let(:page_title) { user.name }
		it_should_behave_like "all user pages"
	end

end
