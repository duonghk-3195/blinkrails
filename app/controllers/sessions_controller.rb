class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        # binding.pry
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else 
        message = "Account is not activated. Please check your email for the activation link."
        flash[:warning] = message
        redirect_to login_url
      end
    else
      flash.now[:danger] = "Email or password is incorrect"
      render :new
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_path
  end

end
