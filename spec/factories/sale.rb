FactoryBot.define do
  factory :sale do
    date { DateTime.now }
    code { Faker::Code.nric }
    description { Faker::Hipster.sentence(5) }
    amount { Faker::Number.decimal(1, 2) }
  end
end
