FactoryGirl.define do	
	factory :user do
		name									"David Foster Wallace"
		email									"one.second@gmail.com"
		password							"foobar"
		password_confirmation "foobar"
	end
end