namespace :db do
	desc "Fill database with sample database"
	task populate: :environment do
		admin = User.create!(name: "Seth Hayward",
								 email: "seth.hayward@gmail.com",
								 password: "foobar",
								 password_confirmation: "foobar")
		admin.user_type = UserType[:admin]
		admin.save(validate: false)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password)
		end
	end	
end