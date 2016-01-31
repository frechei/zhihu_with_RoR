class QuestionsController < ApplicationController
  def index
    
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
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

  private
    def question_params
      params.require(:question).permit(:issue, :description, :topic)
    end
end
