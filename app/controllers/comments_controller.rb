class CommentsController < ApplicationController
	before_action :authenticate_user, only: [:create,  :create_reply]
	before_action :find_comment, only: [:show, :update, :destroy]


  def create
		@comment =Comment.create(text:params[:text],user_id: @current_user.id, post_id:params[:post_id])
		@comment.save
		render json: CommentSerializer.new(@comment).as_json, status: :ok
  end

	def create_reply
	  @comment = Comment.find_by(id: params[:id])
	  @reply = @comment.replies.new(text: params[:text], user_id: @current_user.id, post_id: @comment.post_id)
    if @reply.save   
     render json: @reply, status:201
     else
      render json: {erors: @reply.errors.full_messages}, status:  503
    end
  end

  def show
	 @reply = Comment.find_by(id: params[:id])
	 @reply.present?
	 render json: @reply, status: 200
  end

	def index
	  @comment = Comment.all
	  render json: @comment, status: :ok
	end

	def show
	 @comment = Comment.find_by(id: params[:id])
	 render json: @comment, status: 200
	end

	def update
		@comment.update(comment_params)
		render json: {message: 'comment successfuly updated.'}, status: 200
	end

	def destroy
	 @comment.destroy
	 render json: { message: 'comment successfuly deleted.'}, status: 200
	end


  private

  def comment_params
  	params.permit(:text)
  end


   def find_comment
  	@comment = Comment.find_by(id: params[:id])
  	return render json: {message: "comment with id #{params[:id]} not found"}, status:404 unless @comment
  end
end


