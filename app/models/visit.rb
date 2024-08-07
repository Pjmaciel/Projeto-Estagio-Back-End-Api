class Visit < ApplicationRecord
  belongs_to :user

  enum status: {
    PENDING: 'PENDENTE',
    REALIZING: 'REALIZANDO',
    CARRIED_OUT: 'REALIZADA'
  }, _suffix: true

  validates :date, presence: true, comparison: { greater_than_or_equal_to: -> { Date.current } }
  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) }
  validates :checkin_at, presence: true, comparison: { less_than: :checkout_at }
  validates :checkout_at, presence: true, comparison: { greater_than: :checkin_at }
  validates :user_id, presence: true

  before_save :debug_status

  private

  def debug_status
    Rails.logger.debug "Status before save: #{self.status}"
  end
end
