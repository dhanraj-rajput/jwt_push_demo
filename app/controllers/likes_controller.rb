class LikesController < ApplicationController
	before_action :authenticate_user, only: [:create]
	before_action :find_like, only: [:show, :update, :destroy]


	def create
		@like =Like.create(text:params[:text],user_id: @current_user.id, post_id:params[:post_id],comment_id:params[:comment_id])
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
	 @like = Like.find_by(id: params[:id])
	 render json: @like, status: 200
	end

	def update
	 @like.update(like_params)
	 render json: {message: 'like successfuly updated.'}, status: 200
	end

	def destroy
	 @like.destroy
	 render json: { message: 'like successfuly deleted.'}, status: 200
	end


  private

  def like_params
  	params.permit(:text, :comment_id, :post_id)
  end


  def find_like
   @like = Like.find_by(id: params[:id])
  	return render json: {message: "like with id #{params[:id]} not found"}, status:404 unless @like
  end
end





