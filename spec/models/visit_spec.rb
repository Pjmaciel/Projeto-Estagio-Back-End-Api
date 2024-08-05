# spec/models/visit_spec.rb
require 'rails_helper'

RSpec.describe Visit, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "is valid with valid attributes" do
    visit = Visit.new(user: user, date: Date.today, status: 'PENDENTE', checkin_at: 2.hours.ago, checkout_at: 1.hour.ago)
    expect(visit).to be_valid
  end

  it "is not valid with a past date" do
    visit = Visit.new(user: user, date: Date.yesterday, status: 'PENDENTE', checkin_at: 2.hours.ago, checkout_at: 1.hour.ago)
    expect(visit).to_not be_valid
    expect(visit.errors[:date]).to include("must be greater than or equal to #{Date.today}")
  end

  it "is not valid without a status" do
    visit = Visit.new(user: user, date: Date.today, checkin_at: 2.hours.ago, checkout_at: 1.hour.ago)
    expect(visit).to_not be_valid
    expect(visit.errors[:status]).to include("can't be blank")
  end

  it "raises an error with an invalid status" do
    expect {
      Visit.new(user: user, date: Date.today, status: 'INVALID', checkin_at: 2.hours.ago, checkout_at: 1.hour.ago)
    }.to raise_error(ArgumentError, "'INVALID' is not a valid status")
  end

  it "is not valid with checkin_at after checkout_at" do
    visit = Visit.new(user: user, date: Date.today, status: 'PENDENTE', checkin_at: 1.hour.ago, checkout_at: 2.hours.ago)
    expect(visit).to_not be_valid
    expect(visit.errors[:checkin_at]).to include("must be less than #{visit.checkout_at}")
  end

  it "is not valid with checkout_at before checkin_at" do
    visit = Visit.new(user: user, date: Date.today, status: 'PENDENTE', checkin_at: 2.hours.ago, checkout_at: 1.hour.ago)
    expect(visit).to be_valid

    visit.checkout_at = 3.hours.ago
    expect(visit).to_not be_valid
    expect(visit.errors[:checkout_at]).to include("must be greater than #{visit.checkin_at}")
  end

  it "is not valid without a user_id" do
    visit = Visit.new(date: Date.today, status: 'PENDENTE', checkin_at: 2.hours.ago, checkout_at: 1.hour.ago)
    expect(visit).to_not be_valid
    expect(visit.errors[:user]).to include('must exist')
  end

  it "is not valid without a checkin_at" do
    visit = Visit.new(user: user, date: Date.today, status: 'PENDENTE', checkout_at: 1.hour.ago)
    expect(visit).to_not be_valid
    expect(visit.errors[:checkin_at]).to include("can't be blank")
  end

  it "is not valid without a checkout_at" do
    visit = Visit.new(user: user, date: Date.today, status: 'PENDENTE', checkin_at: 2.hours.ago)
    expect(visit).to_not be_valid
    expect(visit.errors[:checkout_at]).to include("can't be blank")
  end
end
