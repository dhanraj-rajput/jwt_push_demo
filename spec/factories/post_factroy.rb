FactoryBot.define do
  factory :post do
  	description { "post#{Random.rand(1..100)}" }
  	total_likes {"3#{Random.rand(1..100)}"}
  end
end