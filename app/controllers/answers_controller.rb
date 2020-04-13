class AnswersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  after_action :authorize_answers, only: [:create]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.save
    redirect_to @question
  end

  private
  def authorize_answers
    authorize Answer
  end
  def answer_params
    params.require(:answer).permit(:text)
  end
end
