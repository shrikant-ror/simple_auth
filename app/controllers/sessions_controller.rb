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
        cookies.signed[:user_id] = { value: user.id, expires: 2.weeks.from_now }
      else
        cookies.signed[:user_id] = user.id
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
    cookies.delete :user_id
    redirect_to login_path, notice: 'Successfully logged out!!!'
  end
end
