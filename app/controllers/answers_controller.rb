class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :show]
  before_action :logged_in_user, only: [:create]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.replier_id = current_user.id
    
    if @answer.save
      @answer.create_activity :create, owner: current_user
      flash[:notice] = "回答成功"
      redirect_to @question
    else
      flash.now[:alert] = "回答失败"
      render 'questions/show'
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @topics = @question.topics
  end

  def vote
    @answer = Answer.find(params[:id])
    if AnswerVote.exists?(answer_id: params[:id], user_id: current_user.id)
      vote =  current_user.answer_votes.where(answer_id: params[:id]).first
      vote.value = params[:value].to_i
    else
      vote = current_user.answer_votes.build(answer_id: params[:id], value: params[:value].to_i)
    end

    if vote.save!
      vote.create_activity :vote, owner: current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      redirect_to :back, alert: "投票失败，可能之前已投过"
    end
  end


  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:content)
    end

    def logged_in_user
      unless logged_in?
        flash[:info] = "请先登陆"
        redirect_to login_url
      end
    end
end
