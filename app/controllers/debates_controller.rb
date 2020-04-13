class DebatesController < ApplicationController
  skip_before_action :authenticate_user!
  # after_action :authorize_debates
  after_action :authorize_debates, only: [:index, :new, :create, :show]

  def index
    policy_scope(Debate) if current_user
  end

  def new
    # word = the word that is going to be before the token
    session[:word] = params[:global_word]
    session[:sub_string] = params[:sub_string] + params[:global_word]
    @object = params[:object_type].constantize.find(params[:object_id])
    @debate = Debate.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @debate = Debate.find(params[:id])
    @for_arguments = @debate.arguments.where(argument_type: 'For')
    @neutral_arguments = @debate.arguments.where(argument_type: 'Neutral')
    @against_arguments = @debate.arguments.where(argument_type: 'Against')
    policy_scope(Debate) if current_user
  end

  def create
    begin
      global_word = session[:word]
      sub_string = session[:sub_string]
      model_name = params[:debate][:object_type]
      post_id = params[:debate][:object_id]
      @object = model_name.constantize.find(post_id)
      token = create_token(post_id)

      @debate = Debate.new(debate_params)
      @debate.token = token
      if @debate.save
        link = " <a href=\"#{debate_path(@debate.id)}\"> <i class=\"fa fa-comments pr-5 mr-5\" style=\"padding-right: 10px;\" aria-hidden=\"true\"></i> </a> "
        whole_sub_line = @object.is_a?(Post) ? @object.post_body : @object.tag_body
        # with_link = whole_sub_line.split(global_word)[0] + global_word + link + whole_sub_line.split(global_word)[1]
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

  private

  def debate_params
    params.require(:debate).permit(:central_argument)
  end

  def authorize_debates
    authorize Debate
  end

  def create_token(post_id)
    token = Token.new(post_id: post_id, user_id: current_user.id, token_type: 'Debate')
    token.save
    token
  end
end
