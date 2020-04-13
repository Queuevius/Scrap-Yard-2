class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :authorize_questions
  def new
    # word = the word that is going to be before the token
    session[:word] = params[:global_word]
    session[:sub_string] = params[:sub_string] + params[:global_word]
    @object = params[:object_type].constantize.find(params[:object_id])
    @question = Question.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    begin
      # get details from session
      global_word = session[:word]
      sub_string = session[:sub_string]
      model_name = params[:question][:object_type]
      post_id = params[:question][:object_id]
      @object = model_name.constantize.find(post_id)
      token = create_token(@object.id)

      @question = Question.new(question_params)
      @question.token = token
      if @question.save
        link = "<a href=\"#{question_path(@question.id)}\"> <i class=\"fa fa-question-circle-o pr-5 mr-5\" style=\"padding-right: 10px;\" aria-hidden=\"true\"></i> </a>"
        whole_sub_line = @object.is_a?(Post) ? @object.post_body : @object.tag_body
        # with_link = whole_sub_line.split(sub_string)[0] + sub_string + link + whole_sub_line.split(sub_string)[1]
        with_link = whole_sub_line.sub!(sub_string, sub_string + link)
        if @object.is_a?(Post)
          @object.update_attributes(post_body: with_link)
        elsif @object.is_a?(Tag)
          @object.update_attributes(tag_body: with_link)
        end
      end
    rescue => e
      raise e
    end
    respond_to do |format|
      format.js
      format.html
      format.json { render json: { object: @object } }
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  private

  def question_params
    params.require(:question).permit(:text)
  end

  def authorize_questions
    authorize Question
  end

  def create_token(post_id)
    token = Token.new(post_id: post_id, user_id: current_user.id, token_type: 'Question')
    token.save
    token
  end
end
