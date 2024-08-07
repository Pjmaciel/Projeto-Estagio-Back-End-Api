FactoryBot.define do
  factory :formulary do
    sequence(:nome) { |n| "Formulary #{n}" }
  end
end