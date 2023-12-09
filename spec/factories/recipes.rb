FactoryBot.define do
  factory :recipe do
    title { "サンプルレシピ" }
    description { "これはサンプルのレシピ説明です。" }
    total_calories { 500 }
    user
  end
end
