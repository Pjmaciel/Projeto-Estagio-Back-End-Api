# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    cpf { UserFactoryHelper.next_cpf }
  end
end


