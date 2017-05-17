class UsersController < ApplicationController
  layout 'user', except: [:new, :create]
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit_profile'
    end
  end


  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    # Before filters

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
