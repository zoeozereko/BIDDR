FactoryGirl.define do
  factory :auction do
    title Faker::Commerce.product_name
    details Faker::Lorem.paragraph
    ends_on Faker::Date.forward(30)
    reserve_price 5000
  end

end
