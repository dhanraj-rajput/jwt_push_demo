FactoryBot.define do
  factory :like do
  	text { "like#{Random.rand(1..100)}" }
  	comment_id  { "3#{Random.rand(1..100)}" }
  end
end