class SessionsController < ApplicationController

  # Login page
  def new
  end

  def create
    # Find user by using email
    user = User.find_by(email: params[:login][:email].downcase)

    # check user exists and email / password combination is correct.
    if user && user.authenticate(params[:login][:password])
      # Store user_id of logged in user into session.
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!!!'
    else
      # if email / password combination is incorrect then render to login page
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def destroy
    # delete the saved user_id from the cookie:
    session.delete(:user_id)
    redirect_to login_path, notice: 'Successfully logged out!!!'
  end
end
