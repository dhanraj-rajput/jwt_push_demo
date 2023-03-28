class PostsController < ApplicationController
  before_action :authenticate_user, only: [:create]
	before_action :find_post, only: [:show, :update, :destroy]



	def create
		@post = @current_user.posts.new(post_params)
		if @post.save
			render json: PostSerializer.new(@post).as_json, status: :ok
		else
			render json: {erors: @post.errors.full_messages}, status: 503
		end
	end


	def index
	 	@post = Post.all
	 	 render json: @post, status: :ok

	end

	def show
		render json: @post, status: 200
	end

	def update
	
		unless @current_user.post.update(post_params)
			render json: {erors: @post.errors.full_messages}, status: 503
		end
	end

	def destroy
		@post.destroy
	end


  private

  def post_params
  	params.permit(:description, images: [])
  end


   def find_post
  	@post = Post.find(params[:id])
  end
end
