FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "My Text is the best text and you know it."
    private false
    user nil
  end
end
