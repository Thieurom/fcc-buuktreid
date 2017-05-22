class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirm a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
      end
    end

    # Confirm the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless correct_user?(@user)
    end
end
