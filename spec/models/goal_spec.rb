require 'spec_helper'

describe Goal do

	let(:user) { FactoryGirl.create(:user) }	
	before do
		@goal = user.goals.build(title: "lose weight")
	end

	subject { @goal }

	it { should respond_to(:title) }
	it { should respond_to(:user_id) }
	it { should respond_to(:status) }
	it { should respond_to(:updates) }
	it { should respond_to(:user) }
	its(:user) { should == user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @goal.user_id = nil }
		it { should_not be_valid }
	end

	describe "with blank title" do
		before { @goal.title = " " }
		it { should_not be_valid }
	end

	describe "with a title that is too long" do
		before { @goal.title = "a" * 256 }
		it { should_not be_valid }
	end

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				Goal.new(user_id: user.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "update associations" do

		before { @goal.save }
		let!(:older_update) do
			FactoryGirl.create(:update, goal: @goal, created_at: 1.day.ago)			
		end
		let!(:newer_update) do
			FactoryGirl.create(:update, goal: @goal, created_at: 1.hour.ago)
		end

		it "should have the right updates in descending order" do
			@goal.updates.should == [newer_update, older_update]
		end

	end

end
