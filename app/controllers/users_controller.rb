class UsersController < ApplicationController
	skip_before_action :authenticate_user, only: [:create]
	before_action :find_user, only: [:show, :update, :destroy]


	def create
		@user = User.new(user_params)
		if @user.save
			render json: UserSerializer.new(@user).as_json,  status: 201
		else
			render json: {erors: @user.errors.full_messages}, status: 503
		end
	end


	def index
	 	@user = User.all
	 	 render json: @user, status: 201 
	end

	def show
	  @user = User.find_by(id: params[:id])
	  render json: @user, status: 200
	end

	def update
		@user.update(user_params)
		render json: {message: 'user successfuly updated.'}, status: 200
	end
 
	def destroy
		@user.destroy
		render json: { message: 'user successfuly deleted.'}, status: 200
	end

  private

  def user_params
  	params.permit(:user_name, :email, :password, :profile)
  end


   def find_user
  	@user = User.find_by(id: params[:id])

  	return render json: {message: "user with id #{params[:id]} not found"}, status:404 unless @user
  end

end
