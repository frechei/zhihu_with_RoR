class TopicsController < ApplicationController
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
end
