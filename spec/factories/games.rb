FactoryGirl.define do
  factory :game do
    created_by { Faker::StarWars.character }
  end
end
