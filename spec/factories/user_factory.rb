FactoryBot.define do
  factory :user do
  	user_name { "user0#{Random.rand(1..100)}" }
    email  { "test#{Random.rand(1..100)}@gmail.com" }
    password { "Password@123" }
  end
end