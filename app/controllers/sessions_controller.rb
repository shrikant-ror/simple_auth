class SessionsController < ApplicationController

  # Login page
  def new
  end

  def create
    # Find user by using email
    user = User.find_by(email: params[:login][:email].downcase)

    # check user exists and email / password combination is correct.
    if user && user.authenticate(params[:login][:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = { value: user.auth_token, expires: 2.weeks.from_now }
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to home_path, notice: 'Successfully logged in!!!'
    else
      # if email / password combination is incorrect then render to login page
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def destroy
    # delete the saved user_id from the cookie:
    cookies.delete(:auth_token)
    redirect_to login_path, notice: 'Successfully logged out!!!'
  end
end
