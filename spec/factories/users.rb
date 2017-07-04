FactoryGirl.define do

  factory :user do
    username "blocpedia"
    sequence(:email){|n| "user#{n}@factory.com" }
    password "blahaa"
    password_confirmation "blahaa"
  end
end
