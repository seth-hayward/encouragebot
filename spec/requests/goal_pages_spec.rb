require 'spec_helper'

describe "Goal pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:goal) { user.goals.create(title: "Lose weight") }
	before do  
		sign_in user
	end

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

	describe "individual goal page" do
		let(:another_user) { FactoryGirl.create(:user, email: "oblivious@gmail.com") }
		let(:another_goal) { another_user.goals.create(title: "Be more aware") }

		before { visit goal_path(goal) }

		it { should have_selector('title', text: goal.title) }
		it { should have_selector('h1', text: goal.title) }

		it "it should not be accessible by another user" do
			get goal_path(another_goal)
			expect { response.should redirect_to(root_path) }		
		end

		describe "update creation" do
			before { visit goal_path(goal) }

			describe "invalid updates" do
				before { click_button "Add update" }
				it { should have_error_message('') }
			end
		end

	end

end
