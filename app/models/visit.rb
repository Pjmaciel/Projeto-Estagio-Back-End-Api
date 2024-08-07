class Visit < ApplicationRecord
  belongs_to :user

  enum status: {
    PENDING: 'PENDENTE',
    REALIZING: 'REALIZANDO',
    CARRIED_OUT: 'REALIZADA'
  }

  validates :date, presence: true, comparison: { greater_than_or_equal_to: -> { Date.current } }
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) }
  validates :checkin_at, presence: true, comparison: { less_than: :checkout_at }
  validates :checkout_at, presence: true, comparison: { greater_than: :checkin_at }
  validates :user_id, presence: true
end
