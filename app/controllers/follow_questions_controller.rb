class FollowQuestionsController < ApplicationController
	before_action :logged_in_user

	def create
		@question = Question.find(params[:followed_qs_id])
		current_user.follow_a_question(@question)
		@question.create_activity :follow, owner: current_user
		respond_to do |format|
			format.html { redirect_to @question }
			format.js
		end
	end

	def destroy
		@question = FollowQuestion.find(params[:id]).followed_qs
		current_user.unfollow_a_question(@question)
		respond_to do |format|
			format.html { redirect_to @question }
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
