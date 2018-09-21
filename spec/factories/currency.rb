FactoryBot.define do
  factory :currency do
    name { Faker::Currency.name }
    code { Faker::Currency.code }
    sign { Faker::Currency.symbol }
    rate { Faker::Number.decimal(1, 2) }
  end
end
