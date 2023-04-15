class User < ApplicationRecord
	has_one_attached :profile
	has_secure_password
	has_many :posts
	has_many :comments
	has_many :likes
end
