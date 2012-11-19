require 'spec_helper'

describe Update do

	let(:user) { FactoryGirl.create(:user) }
	let(:goal) { FactoryGirl.create(:goal, user: user, title: "Pure class") }

	before do
		@update = goal.updates.build(value: 1)
	end 

	subject { @update }

	it { should respond_to(:value) }
	it { should respond_to(:goal_id) }
	it { should respond_to(:goal) }
	its(:goal) { should == goal }

	describe "accessible attributes" do
		it "should not allow access to goal_id" do
			expect do
				Update.new(goal_id: goal.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "when goal_id is not present" do
		before { @update.goal_id = nil }
		it { should_not be_valid }
	end
end
