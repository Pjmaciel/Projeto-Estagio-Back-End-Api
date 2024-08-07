class Answer < ApplicationRecord
  belongs_to :formulary
  belongs_to :question
  belongs_to :visit

  validates :question_id, presence: true
  validates :formulary_id, presence: true
end
