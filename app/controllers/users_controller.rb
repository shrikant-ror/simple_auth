class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # To aviod case-sensitive login errors store emails in lowercase (same as gmail stores emails).
    @user.email.downcase!

    if @user.save
      # show success message to user.
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      # If any error occured while storing user then show error message to end user.
      flash.now.alert = "Oops, Someting went wrong while creating Account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  private

  def user_params
    # whitelist of allowed fields that can be submitted by a form
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
