class UsersController < ApplicationController
  before_action :set_user , only: [:edit, :update, :followings, :followers]
  before_action :check_user , only: [:edit, :update]
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice: '編集しました'
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "フォロー一覧"
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー一覧"
    @users = @user.follower_users
    render 'show_follow'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :password, :password_confirmation)
  end
  
  def set_user
     @user = User.find(params[:id])
  end
  
  def check_user
    if @user != current_user
      redirect_to root_url
    end
  end
end
