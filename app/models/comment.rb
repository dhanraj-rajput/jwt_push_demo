class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post
	has_many :likes
	#has_many :comments_comment, class_name: "Comment", foreign_key: "reply id"
   belongs_to :comment, class_name: "Comment",foreign_key: 'reply_id', optional: true
   has_many :replies, class_name: 'Comment', foreign_key: 'reply_id'


end
