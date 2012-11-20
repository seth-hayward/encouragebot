require 'spec_helper'

describe "Goal pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:goal) { user.goals.create(title: "Lose weight") }
	let!(:hidden_goal) { user.goals.create(title: "Super Secret goal that was hidden", status: 0)}
	let!(:initial_update) { goal.updates.create(value: 100.5) }

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
		it { should have_selector("li##{initial_update.id}", text: "#{initial_update.value}") }

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

			describe "valid updates" do
				before do
					fill_in "Value", 	with: "5"
				end
				it "should create an update" do 
					expect { click_button "Add update" }.should change(Update, :count).by(1)
				end				
			end

			describe "deleting updates" do

				it "should remove the update" do
					expect { click_link("delete") }.should change(Update, :count).by(-1)
				end

			end

		end

	end

	describe "hidden goal page" do

		before { visit hidden_path }

		it { should have_selector('title', text: 'hidden goals') }
		it { should have_selector('h1', text: "Hidden Goals") }
		it { should have_selector('li', text: hidden_goal.title) }
		it { should_not have_selector('li', text: goal.title) }

		describe "should allow unhiding goals" do
			it { should have_link("unhide", href: unhide_goal_path(hidden_goal)) }

			it "should change hidden goals when linked clicked" do
				expect { click_link "unhide" }.to change(Goal.where("status = 0"), :count).by(-1)
			end

		end



	end

end
