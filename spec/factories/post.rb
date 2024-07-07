FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 15) }
    caption { Faker::Lorem.characters(number: 50) }
    body { Faker::Lorem.characters(number: 1000) }
    prefecture { rand(0..48) }
    user
    after(:build) do |post|
      post.post_image.attach(io: File.open("spec/images/post_image.jpeg"), filename: "post_image.jpeg", content_type: "application/xlsx")
    end
  end
end
