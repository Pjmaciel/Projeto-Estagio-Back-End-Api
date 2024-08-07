class Formulary < ApplicationRecord
  has_many :questions
  validates :nome, presence: true, uniqueness: true
end
