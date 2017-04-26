FactoryGirl.define do
  factory :user do
    password "123456"
    sequence(:email){|n| "dummy_#{n}@factory.com"}
  end
end
