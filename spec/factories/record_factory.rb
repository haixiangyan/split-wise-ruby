FactoryBot.define do
  factory :record do
    amount { 10000 }
    category { 'income' }
    user
  end
end
