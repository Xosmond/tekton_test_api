FactoryBot.define do
  factory :spending do
    date { DateTime.now }
    code { Spending::CODES.map {|item| item[:code]}.sample }
    description { Faker::Hipster.sentence(5) }
    amount { Faker::Number.decimal(1, 2) }
  end
end
