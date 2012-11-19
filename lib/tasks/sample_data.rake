namespace :db do
	desc "Fill database with sample database"
	task populate: :environment do
		admin = User.create!(name: "Seth Hayward",
								 email: "seth.hayward@gmail.com",
								 password: "foobar",
								 password_confirmation: "foobar")
		admin.user_type = UserType[:admin]
		admin.goals.create!(title: "Stop smoking")
		admin.save(validate: false)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			new_guy = User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password)
			new_goal = new_guy.goals.create!(title: Faker::Lorem.sentence(3))
			new_goal.updates.create!(value: n)
		end
	end	
end