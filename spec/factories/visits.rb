FactoryBot.define do
  factory :visit do
    user
    date { Date.today }
    status { :PENDING }
    checkin_at { Time.now }
    checkout_at { Time.now + 1.hour }
  end
end