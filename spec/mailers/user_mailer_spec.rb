require "spec_helper"

describe UserMailer do

	describe "welcome email" do

		let(:user) { FactoryGirl.create(:user) }
		let(:mail) { UserMailer.welcome_email(user) }

		it "renders the subject" do
			mail.subject.should == "Welcome to Encourage Bot"
		end

		it "renders the receiver email" do
			mail.to.should == [user.email]
		end

		it "renders the sender email" do
			mail.from.should == ["no-reply@encouragebot.com"]
		end

		it "assigns @name" do
			mail.body.encoded.should match(user.name)			
		end

		it "should have the login link" do
			mail.body.encoded.should match("http://encouragebot.heroku.com/login")
		end

	end

end
