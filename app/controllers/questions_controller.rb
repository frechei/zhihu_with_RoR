class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update]
  def index
    
  end

  def new
    @question = Question.new
  end

  def show
    @answer = @question.answers.build
  end

  def create
    @question = Question.new(question_params)

    if @question.save
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
      params.require(:question).permit(:issue, :description, :topic)
    end
end
