class CommentsController < ApplicationController
	before_action :authenticate_user, only: [:create, :index, :create_reply]
	before_action :find_comment, only: [:show, :update, :destroy]


	def create

		@comment =Comment.create(text:params[:text],user_id: @current_user.id, post_id:params[:post_id])
		if @comment.save
		else
			render json: {erors: @comment.errors.full_messages}, status: 503
		end
	end

		def create_reply
        @comment = Comment.find_by(id:params[:id])
        @reply = @comment.replies.create(text: params[:text], user_id: @current_user.id)
      
        if @reply.present  
		   render json: CommentSerializer.new(@comment).as_json,  status: 201


           render json: @reply, status:201
         else
          render json: {erors: @reply.errors.full_messages}, status:  503
        end
      end

  def show

		@reply = Comment.find_by(id: params[:id])
		if @reply.present?
		render json: @reply, status: 200
	  else
	  	render json: {message: "reply with id #{params[:id]} not found"}, status:404
	  end
	end




	def index
	 	@comment = Comment.all
	 	@comment = @comment.where(post_id: params[:post_id]) if params[:post_id].present?
	 	 render json: @comment, status: :ok
	end

	def show
		render json: @comment, status: 200
	end

	


	def update
	
		unless @comment.update(comment_params)
			render json: {erors: @comment.errors.full_messages}, status: 503
		end
	end

	def destroy
		@comment.destroy
	end


  private

  def comment_params
  	params.permit(:text)
  end


   def find_comment
  	@comment = Comment.find(params[:id])
  end
end


