FactoryBot.define do
  factory :user do
    name { 'Pedro José'}
    email { 'pedro.jose@example.com' }
    cpf { "587.330.870-59" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
