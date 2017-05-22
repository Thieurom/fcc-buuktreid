class PasswordChangeController < ApplicationController

  layout 'user'
  before_action :get_user
  before_action :logged_in_user
  before_action :correct_user

  def new
  end

  def create
    if @user.authenticate(params[:password][:current_password])
      if params[:password][:password].empty?
        flash[:error] = "Password can't be empty."
        render 'new'
      elsif @user.update_attributes(password_params)
        flash[:notice] = "Password has been changed. Please login again."
        log_out
        redirect_to login_url
      else
        render 'new'
      end
    else
      flash[:error] = "Incorrect current password."
      render 'new'
    end
  end


  private

    def get_user
      @user = User.find(params[:id])
    end

    def password_params
      params.require(:password).permit(:password)
    end
end
