FactoryBot.define do
  factory :employee do
    doc { Faker::Number.number(8) }
    names { Faker::Name.first_name }
    last_names { Faker::Name.last_name }
    birth_date { Faker::Date.between(30.years.ago, 20.years.ago) }
  end
end
