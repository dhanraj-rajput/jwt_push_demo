class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session

	include JwtToken

	before_action :authenticate_user, except: :admin
	before_action :set_env_base_url

	private

	def set_env_base_url
    unless ENV['BASE_URL'].present?
      ENV['BASE_URL'] = request.base_url
    end
  end


	def authenticate_user
		header = request.headers['Authorization']
		header = header.split(' ').last if header
		begin
			@decoded = jwt_decode(header)
			@current_user = User.find(@decoded[:user_id])
		rescue ActiveRecord::RecordNotFound => e  
			render json: {errors: e.message },status: :unauthorized
		rescue JWT::DecodeError => e  
			render json: {errors: e.message },status: :unauthorized
		end
	end

end

