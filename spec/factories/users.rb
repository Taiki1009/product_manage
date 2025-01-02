FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    name { 'name' }
    password { 'password' }
  end
end
