class ActivitiesController < ApplicationController
	before_action :logged_in_user

  def index
  	@activities = PublicActivity::Activity.order("created_at desc")
  				.where(owner_id: current_user.following, owner_type: "User")
  end

  private
  	def logged_in_user
      unless logged_in?
        flash[:info] = "请先登陆"
        redirect_to login_url
      end
    end
end
