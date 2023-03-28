class CommentSerializer < ActiveModel::Serializer
  attributes :id,  :post_id, :text, :created_at, :updated_at, :replies, :text


    def replies
     object.replies.map do |reply|
       CommentSerializer.new(reply, root: false)
      #replies = Comment.replies.pluck(:content)
      #replies = Comment.replies.map { |reply| {id: reply.id, content: reply.content} }

    end
  end

  attribute :reply do |ssd|
    object.replies
  end
end



