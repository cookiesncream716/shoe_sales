class ApplicationController < ActionController::Base
	# def current_user
 #  	 User.find(session[:user_id]) if session[:user_id]
 #  end
 #  def require_login_in
	# 	redirect_to "/" if session[:user_id] == nil
	# end

	# def require_correct_user
	# 	user = User.find(params[:id])
	# 	redirect_to "/users/#{current_user}" if current_user != user
	# end

  helper_method :current_user
  
  protect_from_forgery with: :exception
end
