class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destory, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # 由于没有信用卡，heroku的mailgun先不能用
      # @user.send_activation_email
      # flash[:info] = "请到邮箱激活帐号"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @activities = PublicActivity::Activity.order("created_at desc")
        .where(owner_id: @user, owner_type: "User")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      log_in(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户删除成功"
    redirect_to root_url
  end

  def following
    @title = "关注了的人"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_form'
  end

  def followers
    @title = "关注我的人"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_form'
  end

  def topics
    @user = User.find(params[:id])
    @title = @user.name + "关注的话题"
    @topics = @user.followed_tp.paginate(page: params[:page])
    render 'show_topics'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar, 
                                   :location, :vocation, :gender, :company, :position,
                                   :education, :major, :statements)
    end

    def logged_in_user
      unless logged_in?
        flash[:info] = "请先登陆"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
