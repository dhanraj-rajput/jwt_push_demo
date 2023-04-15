class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post
	has_many :likes
	has_one_attached :attch
   belongs_to :comment, class_name: "Comment",foreign_key: 'reply_id'
   has_many :replies, class_name: 'Comment', foreign_key: 'reply_id'


end
