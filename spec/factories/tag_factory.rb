FactoryBot.define do
  factory :tag do
    name { SecureRandom.hex 2 }
    user
  end
end
