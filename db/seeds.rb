User.create!(name:    "Filby Federson",
             email:   "feder@filby.com",
             password:              "Password9",
             password_confirmation: "Password9",
             activated: true,
             activated_at: Time.zone.now)

emails = []
99.times do |n|
  test = Faker::Internet.email
  emails.include?(test) ? redo : emails[n] = test
end

99.times do |n|
  name = Faker::Name.name
  email = emails[n]
  password = "Password9"
  User.create!(name: name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Taker::Lorem.sentence(5)
  users.each { |each| user.microposts.create!(content: content) }
end
