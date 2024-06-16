FactoryBot.define do
  factory :user do
    last_name { Faker::Lorem.characters(number:5) }
    first_name { Faker::Lorem.characters(number:5) }
    canonical_name { Faker::Lorem.characters(number:6) }
    public_name { Faker::Lorem.characters(number:6) }
    position { rand(0..2) }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    after(:build) do |user|
      user.profile_image.attach(io: File.open("spec/images/profile_image.jpeg"), filename: "profile_image.jpeg", content_type: "application/xlsx")
    end
  end
end