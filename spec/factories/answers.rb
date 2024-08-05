FactoryBot.define do
  factory :answer do
    content { "Resposta 1" }
    formulary
    question
    visit
    answered_at { DateTime.now }
  end
end