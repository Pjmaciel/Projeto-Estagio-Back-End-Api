FactoryBot.define do
  factory :visit do
    date { Date.today }
    status { :PENDING }
    user
    checkin_at { Time.now }
    checkout_at { Time.now + 1.hour }
  end
end
