FactoryBot.define do
  factory :question do
    sequence(:name) { |n| "Question #{n}" }
    formulary
    question_type { "type" }
  end
end