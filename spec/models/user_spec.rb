require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Example User", email: "user@example.com",
										 password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:user_type) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:goals) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM a_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		# in this test, "it" is referring to @user
		# from above, which has NOT been saved to the database yet
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password does not match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when the password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5}
		it { should be_invalid }
	end

	describe "email address with mixed case" do
		let(:mixed_case_email) { "FoO@EXAmplE.cOM" }

		it "should be saved as all lowercase" do
			@user.email = mixed_case_email
			@user.save
			@user.reload.email.should == mixed_case_email.downcase
		end
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			# what this is saying is that "it" (@user) should be
			# equal to itself after pulling found_user from the
			# database, and then using the authenicate method to
			# compare the hashes. this would fail if we tried
			# to use another user.
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			# by passing a password that is not valid (invalid instea of foobar),
			# the hashes won't match. this means the authenticate method returns
			# false, instead of the user object we have to compare it with. 
			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end	

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				User.new(user_type: 100)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "goal associations" do

		before { @user.save }
		let!(:older_goal) do 
			FactoryGirl.create(:goal, user: @user, created_at: 1.day.ago)			
		end

		let!(:newer_goal) do
			FactoryGirl.create(:goal, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right goals in the right order (newer goals first)" do
			@user.goals.should == [newer_goal, older_goal]
		end

		it "should destroy associated goals" do
			goals = @user.goals
			@user.destroy
			goals.each do |goal|
				Goal.find_by_id(goal.id).should be_nil
			end
		end
	end
	
end
