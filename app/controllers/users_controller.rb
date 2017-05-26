class UsersController < ApplicationController
  layout 'user', except: [:new, :create]
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]

  def show
    @user = User.find(params[:id])
    @books = @user.books.where(trading: false)
  end

  def show_trade
    @user = User.find(params[:id])
    @books = @user.books.where(trading: true)
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
end
