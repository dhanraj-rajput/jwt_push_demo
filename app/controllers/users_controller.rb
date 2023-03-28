class UsersController < ApplicationController
	skip_before_action :authenticate_user, only: [:create, :index, :show]
	before_action :find_user, only: [ :update, :destroy]


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
		if @user.present?
		render json: @user, status: 200
	  else
	  	render json: {message: "user with id #{params[:id]} not found"}, status:404
	  end
	end

	def update
		unless @user.update(user_params)
			render json: {erors: @user.errors.full_messages}, status: 503
		end
	end

	def destroy
		@user.destroy
	end


  private

  def user_params
  	params.permit(:user_name, :email, :password, :profile)
  end


   def find_user
  	@user = User.find(params[:id])
  end

end
