class ArgumentsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  after_action :authorize_arguments, only: [:create]

  def create
    @debate = Debate.find(params[:debate_id])
    @argument = @debate.arguments.new(argument_params)
    @argument.save
    redirect_to @debate
  end

  private
  def authorize_arguments
    authorize Argument
  end
  def argument_params
    params.require(:argument).permit(:text, :argument_type)
  end
end
