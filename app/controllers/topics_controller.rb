class TopicsController < ApplicationController
	before_action :logged_in_user, only: [:topic]

	def remove
		@question = Question.find(params[:question_id])
		@topic = Topic.find(params[:id])

		@question.topics.destroy(@topic)
		head :ok
	end

	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def topic
		@topics = current_user.followed_tp
		render 'own_topics'
	end

	private

	 	def logged_in_user
      unless logged_in?
      	flash[:info] = "请先登陆"
        redirect_to login_url
      end
    end
end
