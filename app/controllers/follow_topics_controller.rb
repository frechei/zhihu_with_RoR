class FollowTopicsController < ApplicationController
	before_action :logged_in_user

	def create
		@topic = Topic.find(params[:followed_tp_id])
		current_user.follow_a_topic(@topic)
		@topic.create_activity :follow, owner: current_user
		respond_to do |format|
			format.html { redirect_to @topic }
			format.js
		end
	end

	def destroy
		@topic = FollowTopic.find(params[:id]).followed_tp
		current_user.unfollow_a_topic(@topic)
		respond_to do |format|
			format.html { redirect_to @topic }
			format.js
		end
	end

  private
	  def logged_in_user
	    unless logged_in?
        flash[:info] = "请先登陆"
        redirect_to login_url
      end
	  end
end
