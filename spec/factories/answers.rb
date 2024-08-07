FactoryBot.define do
  factory :answer do
    sequence(:content) { |n| "Sample Answer #{n}" }
    formulary
    question
    visit
    answered_at { Time.now }
  end
end