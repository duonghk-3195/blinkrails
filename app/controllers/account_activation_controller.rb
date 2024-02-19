class AccountActivationController < ApplicationController

    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.activate
            log_in user
            flash[:success] = "Your account has been activated!"
            redirect_to user
        else
            flash[:danger] = "Your account could not be activated!"
            redirect_to root_path
        end
    end

end
