FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "title#{n}"}
    sequence(:body) { |n| "body#{n}"}
  end
end
