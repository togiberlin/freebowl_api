FactoryGirl.define do
  factory :player do
    game
    name { Faker::StarWars.character }
  end
end
