FactoryBot.define do
  factory :comment do
  	text { "comment#{Random.rand(1..100)}" }
  	# reply { "reply#{Random.rand(1..100)}" }
  end
end


FactoryBot.define do
  factory :replies do
  replies { "replies#{Random.rand(1..100)}" }
  	
  end
end