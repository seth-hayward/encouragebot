FactoryGirl.define do	
	factory :user do
		sequence(:name) 	{ |n| "Person #{n}"}
		sequence(:email) 	{ |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"
		
		factory :admin do
			user_type 100
		end
	end

	factory :goal do
		title		"Lorem ipsum"
		status	1
		user
	end

	factory :update do
		value 15
		goal
	end
end