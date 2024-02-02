class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = "Please check your email to reset your password."
      redirect_to login_path
    else
      flash.now[:danger] = "We can't find a user with that email address."
      render 'new'
    end
  end

  def edit

  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be blank")
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = "Your password has been changed."
      redirect_to @user
    else 
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email].downcase)
    end

    def valid_user 
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
        flash[:danger] = "acctive account"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Your password reset link has expired."
        redirect_to new_password_reset_url
      end
    end
end
