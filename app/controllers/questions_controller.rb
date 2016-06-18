class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :update, :create]
  
  def new
    @question = Question.new
  end

  def show
    @answer = @question.answers.build
    @question_comment = @question.comments.build
    @question_comments = @question.comments.all
  end

  def create
    @question = Question.new(question_params)
    @question.questioner_id = current_user.id
    if @question.save
      @question.create_activity :create, owner: current_user
      flash[:notice] = "问题已发布"
      redirect_to question_path(@question)
    else
      flash.now[:alert] = "问题发布失败"
      render "new"
    end
  end

  def edit

  end

  def update
    if @question.update(question_params)
      flash[:notice] = "问题修改成功"
      redirect_to @question
    else
      flash.now[:alert] = "问题修改失败"
      render "edit"
    end

  end

  private
    def set_question
      @question = Question.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "问题不存在"
      redirect_to root_path
    end

    def question_params
      params.require(:question).permit(:issue, :description, :topic_names)
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_url, notice: "请先登陆"
      end
    end
end
