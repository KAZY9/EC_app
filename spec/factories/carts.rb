FactoryBot.define do
  factory :cart do
    quantity { 1 }
    user { nil }
    product { nil }
  end
end
