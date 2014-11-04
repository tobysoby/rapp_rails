class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  layout "not_logged_in.html.erb"
	def create
  		user = User.find_by(email: params[:session][:email].downcase)
  		if user && user.authenticate(params[:session][:password])
    		log_in user
      	redirect_to controller: "runs"
  		else
    		flash.now[:error] = 'Invalid email/password combination'
      	render 'new'
 		end
	end

	def destroy
    	log_out
    	redirect_to root_path
  	end
end
