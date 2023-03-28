class AuthenticationController < ApplicationController
	skip_before_action :authenticate_user, only: :login

	def login
		user = User.find_by(email: params[:email])
		if user.present?
			if user.authenticate(params[:password])
				render json: {
					
					token: jwd_encode({user_id: user.id}),
					exp: Time.now + 24.hours,
					user_name: user.user_name
				
				}, status: :ok
			else
				render json: { errors: "Password is not correct." }, status: :unauthorized
			end
		else
			render json: { errors: "Account Not found" }, status: :unauthorized
		end
	end
end
