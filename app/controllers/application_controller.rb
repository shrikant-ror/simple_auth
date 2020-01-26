class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # allow current_user method in views and controllers
  helper_method :current_user

  # Define the current_user method same as Devise current_user method
  # Look up the current user based on user_id in the session cookie
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
