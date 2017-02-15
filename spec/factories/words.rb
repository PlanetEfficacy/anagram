FactoryGirl.define do
  factory :word do
    value 'pants'

    factory :random_word do
      value { Faker::Lorem.word }
    end
  end
end
