require 'rails_helper'

RSpec.describe Visit, type: :model do
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    visit = Visit.new(date: Date.today, status: :PENDING, user: user, checkin_at: Time.now, checkout_at: Time.now + 1.hour)
    expect(visit).to be_valid
  end

  it "is not valid without a date" do
    visit = Visit.new(date: nil, status: :PENDING, user: user, checkin_at: Time.now, checkout_at: Time.now + 1.hour)
    expect(visit).to_not be_valid
  end

  it "is not valid if date is in the past" do
    visit = Visit.new(date: Date.yesterday, status: :PENDING, user: user, checkin_at: Time.now, checkout_at: Time.now + 1.hour)
    expect(visit).to_not be_valid
  end

  it "is not valid without a status" do
    visit = Visit.new(date: Date.today, status: nil, user: user, checkin_at: Time.now, checkout_at: Time.now + 1.hour)
    expect(visit).to_not be_valid
  end

  it "is not valid with an invalid status" do
    expect {
      Visit.new(date: Date.today, status: :INVALID_STATUS, user: user, checkin_at: Time.now, checkout_at: Time.now + 1.hour)
    }.to raise_error(ArgumentError)
  end

  it "is not valid if checkin_at is greater than or equal to checkout_at" do
    visit = Visit.new(date: Date.today, status: :PENDING, user: user, checkin_at: Time.now + 2.hours, checkout_at: Time.now + 1.hour)
    expect(visit).to_not be_valid
  end

  it "is not valid without checkin_at" do
    visit = Visit.new(date: Date.today, status: :PENDING, user: user, checkin_at: nil, checkout_at: Time.now + 1.hour)
    expect(visit).to_not be_valid
  end

  it "is not valid without checkout_at" do
    visit = Visit.new(date: Date.today, status: :PENDING, user: user, checkin_at: Time.now, checkout_at: nil)
    expect(visit).to_not be_valid
  end
end
