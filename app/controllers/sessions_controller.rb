class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)

        redirect_back_or root_path
      else
        message = "帐号未激活！"
        message += "请到你的邮箱查看激活链接。"
        flash[:warning] = message
        redirect_to root_url
      end

    else
      flash.now[:error] = "帐号密码不符合"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
