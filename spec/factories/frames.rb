FactoryGirl.define do
  sequence :next_frame_number do |n|
    if n == 10
      FactoryGirl.reload # Reset counter back to one
    else
      1 + n
    end
  end

  factory :frame do
    frame_number { FactoryGirl.generate(:next_frame_number) }
    score { Faker::Number.between(0,300) }
    player

    trait :strike do
      ball_one_pins 10
    end

    trait :spare do
      ball_one_pins 7
      ball_two_pins 3
    end

    trait :normal do
      ball_one_pins { Faker::Number.between(1,3) }
      ball_two_pins { Faker::Number.between(1,6) }
      ball_three_pins 0
    end

    trait :last_frame do
      frame_number 10
    end

    trait :last_frame_with_strike do
      frame_number 10
      ball_one_pins 10
      ball_two_pins { Faker::Number.between(0,10) }
      ball_three_pins { Faker::Number.between(0,10) }
    end

    trait :last_frame_with_spare do
      frame_number 10
      ball_one_pins 2
      ball_two_pins 8
      ball_three_pins { Faker::Number.between(0,10) }
    end

    trait :not_last_frame do
      frame_number { Faker::Number.between(1,9) }
    end

    trait :invalid_eleventh_frame do
      frame_number 11
    end

    trait :invalid_partial_score do
      ball_one_pins { Faker::Number.between(4,9) }
      ball_two_pins { Faker::Number.between(7,10) }
    end

    trait :invalid_third_throw do
      frame_number { Faker::Number.between(1,9) }
      ball_one_pins 10
      ball_two_pins { Faker::Number.between(3,5) }
      ball_three_pins { Faker::Number.between(3,5) }
    end
  end
end
