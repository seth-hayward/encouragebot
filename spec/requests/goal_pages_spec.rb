require 'spec_helper'

describe "Goal pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "goal creation" do 
		before { visit new_goal_path }

		it { should have_selector('title', text: 'Add new goal') }
		it { should have_selector('h1', text: 'Add new goal') }

		describe "with invalid information" do

			it "should not create a goal" do
				expect { click_button "Save goal" }.should_not change(Goal, :count)
			end

			describe "error messages" do
				before { click_button "Save goal" }
				it { should have_error_message('') }
			end			
		end

		describe "with valid information" do

			before { fill_in 'goal_title', with: "Lorem ipsum" }
			it "should create a goal" do
				expect { click_button "Save goal" }.should change(Goal, :count).by(1)
			end
		end
	end
end
