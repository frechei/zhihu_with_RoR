class UsersController < ApplicationController
  before_action :sign_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:notice] = "注册成功！欢迎加入知乎。"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "修改成功"
      sign_in(@user)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end

    def sign_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "请先登陆"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
