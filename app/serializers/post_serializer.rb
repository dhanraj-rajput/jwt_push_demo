class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :created_at, :updated_at, :images, :likes_count, :comments_count,
  :user ,:description

  attribute :recently_joined? do |asd|
    Date.today.prev_month < object.created_at
  end

  attribute :images do |ssd|
    if object.images.present? 
      object.images.map do |image|
        { id: image.id,
          content_type: image.content_type,
          url: ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) 
        }
      end
    else
      false
    end
  end


  def likes_count
    object.likes.count
   end

  def comments_count
    object.comments.count
  end

   def user
    object.user
  end 
end