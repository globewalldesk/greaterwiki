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

def title_generator
  "#{Faker::Job.title} in the field of #{Faker::Job.field}. Love #{Faker::Job.key_skill}!"
end

def description_generator
  "I hail from #{Faker::Address.city}, #{Faker::Address.state}. Love #{Faker::Team.sport}. (Go #{Faker::Team.mascot}s!) You know... #{Faker::TwinPeaks.quote} It's true! #{Faker::HitchhikersGuideToTheGalaxy.marvin_quote}

#{Faker::Hipster.paragraph(4, true, 2)}

#{Faker::Hipster.paragraph(4, true, 2)}"
end

99.times do |n|
  name = Faker::Name.name
  email = emails[n]
  password = "Password9"
  title =
  User.create!(name: name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               title: title_generator,
               description: description_generator)
end
