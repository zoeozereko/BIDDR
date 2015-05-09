FactoryGirl.define do
  factory :bid do
    association :auction, factory: :auction
    amount 10
  end

end
