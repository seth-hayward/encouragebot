require 'spec_helper'

describe "User pages" do

	subject { page }

	shared_examples_for "all user pages" do
		it { should have_selector("h1", text: heading) }
		it { should have_selector("title", text: full_title(page_title)) }		
	end

	describe "index" do

		let(:user) { FactoryGirl.create(:user) }

		before(:each) do
			sign_in user
			visit users_path
		end

		let(:heading) { 'All users' }
		let(:page_title) { 'All users' }
		it_should_behave_like "all user pages"

		describe "pagination" do

			before(:all) { 30.times { FactoryGirl.create(:user) } }
    	after(:all)  { User.delete_all }

			it { should have_selector('div.pagination') }
			it "should list each user" do
				User.paginate(page: 1).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end
		end

		describe "delete links" do

			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit users_path
				end

				it { should have_link('delete', href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect { click_link('delete') }.to change(User, :count).by(-1)					
				end

				it { should_not have_link('delete', href: user_path(admin)) }

				describe "it should not allow DELETE from curl" do
					before { delete user_path(admin) }
					specify { response.should redirect_to(root_path) }
				end

			end
		end
	end

	describe "signup page" do
		before { visit signup_path }
		let(:heading) { 'Sign up' }
		let(:page_title) { 'sign up' }
		it_should_behave_like "all user pages"
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		let(:another_user) { FactoryGirl.create(:user, email: "lockout@gmail.com") }		
		let!(:g1) { FactoryGirl.create(:goal, user: user, title: "FooWeAintGotTimeForThat") }
		let!(:g2) { FactoryGirl.create(:goal, user: user, title: "BarBarBarBaRam") }
		let!(:g3) { FactoryGirl.create(:goal, user: user, title: "GoodJobHidingAGoal", status: 0)}

		before do 
			sign_in user
			visit user_path(user)
		end

		let(:heading) { user.name }
		let(:page_title) { user.name }
		it_should_behave_like "all user pages"

		describe "goals" do
			it { should have_content(g1.title) }
			it { should have_content(g2.title) }
			it { should have_selector('h3', text: pluralize(user.goals.where("status = 1").count, "goals")) }

			describe "should not show hidden goals" do
				it { should_not have_selector('li', text: g3.title) }
			end

		end	

		describe "hidden goals" do
			before { visit hidden_path }
			it { should have_selector('li', text: g3.title) }			
		end

		describe "should not allow access to another user's profile" do
			before { get user_path(another_user) }
			specify { response.should redirect_to(root_path) }
		end

		describe "hide goal links" do
			it { should have_link('hide', href: hide_goal_path(g1)) }

			it "should hide goals when clicked" do
				expect { click_link('hide') }.to change(Goal.where("status = 1"), :count).by(-1)
			end

		end

	end

	describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
      	before { click_button submit }

      	it { should have_selector('title', text: 'sign up') }
      	it { should have_error_message('') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
      	before { click_button submit }
      	let(:user) { User.find_by_email('user@example.com') }

      	it { should have_selector('title', text: user.name) }
      	it { should have_success_message("Welcome") }
      	it { should have_link('Sign out') }

	      it "should have sent out a welcome email" do
	      	ActionMailer::Base.deliveries.last.to.should == [user.email]
	      end

	    end
    end

    describe "while signed in and visit create page" do
    	let(:user) { FactoryGirl.create(:user) }
    	before do
	    	sign_in user
	    	get signup_path
    	end
			specify { response.should redirect_to(root_path) }    	
    end

    describe "while signed in and PUT object" do
    	let(:user) { FactoryGirl.create(:user) }
    	before do
    		sign_in user
    		put signup_path(user)
    	end
			specify { response.should redirect_to(root_path) }    	
    end

  end

  describe "edit" do
  	let(:user) { FactoryGirl.create(:user) }
  	before do
  		sign_in(user)
  		visit edit_user_path(user)
  	end

  	describe "page" do
  		it { should have_selector('h1', text: 'Update your profile') }
  		it { should have_selector('title', text: 'Edit user') }
  		it { should have_link('change', href: 'http://gravatar.com/emails') }

  		describe "with invalid information" do
  			before { click_button "Save changes" }

  			it { should have_error_message('') }
  		end
  	end

  	describe "with valid information" do
  		let(:new_name) { "New Name" }
  		let(:new_email) { "new@example.com" }

  		before do
  			fill_in "Name",					with: new_name
  			fill_in "Email", 				with: new_email
  			fill_in "Password", 		with: user.password
  			fill_in "Confirmation", with: user.password
  			click_button "Save changes"
  		end

  		it { should have_selector('title', text: new_name) }
  		it { should have_success_message('') }
  		it { should have_link('Sign out', href: signout_path) }
  		specify { user.reload.name.should == new_name }
  		specify { user.reload.email.should == new_email	}
  	end
	end	
end