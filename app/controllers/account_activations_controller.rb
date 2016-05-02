class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "帐号已经激活"
    else
      flash[:danger] = "激活链接无效"
    end
    redirect_to root_url
  end
end
