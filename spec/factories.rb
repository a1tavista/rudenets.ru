FactoryBot.define do
  factory :notepad_category do
    title { 'MyString' }
  end
  factory :notepad do
    name { 'MyString' }
    text { 'MyString' }
    category { 1 }
  end
  factory :comment do
  end
  factory :link do
  end
  factory :image do
  end
  factory :post do
  end
  factory :entry do
  end
end
