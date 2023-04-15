class PostsController < ApplicationController
    before_action :authenticate_user, only: [:create]
	before_action :find_post, only: [:show, :update, :destroy]



	def create
		@post = @current_user.posts.new(post_params)
	  @post.save
	  render json: PostSerializer.new(@post).as_json, status: :ok
	end


	def index
	 	@post = Post.all
	 	render json: @post, status: :ok
	end

	def show
		@post = Post.find_by(id: params[:id])
	  render json: @post, status: 200
	end

	def update
		@post.update(post_params)
		render json: {message: 'post successfuly updated.'}, status: 200
	end

	def destroy
		@post.destroy
		render json: { message: 'post successfuly deleted.'}, status: 200
	end


  private

  def post_params
  	params.permit(:description, images: [])
  end


   def find_post
  	@post = Post.find_by(id: params[:id])
  	return render json: {message: "post with id #{params[:id]} not found"}, status:404 unless @post
  end
end
