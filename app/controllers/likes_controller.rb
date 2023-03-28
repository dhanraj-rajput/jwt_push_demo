class LikesController < ApplicationController
	before_action :authenticate_user, only: [:create]
	before_action :find_like, only: [:show, :update, :destroy], only: [:post]


	def create

		@like =Like.create(text:params[:text],user_id: @current_user.id, post_id:params[:post_id],
			comment_id:params[:comment_id])
		if @like.save
			render json:  @like,  status: 201
		else
			render json: {erors: @like.errors.full_messages}, status: 503
		end
	end


	def index
	 	@like = Like.all
	 	 render json: @like, status: :ok
	end

	def show
		render json: @like, status: 200
	end

	def update
	
		unless @like.update(like_params)
			render json: {erors: @like.errors.full_messages}, status: 503
		end
	end

	def destroy
		@like.destroy
	end


  private

  def like_params
  	params.permit(:text)
  end


   def find_like
  	@like = Like.find(params[:id])
  end
end





