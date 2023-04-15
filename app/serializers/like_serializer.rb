class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id  :recently_joined?


  def recently_joined?
   Date.today.prev_month < object.created_at
  end
end
