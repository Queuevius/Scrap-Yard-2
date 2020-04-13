class NotesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authorize_notes
  def new
    # word = the word that is going to be before the token
    session[:word] = params[:global_word]
    session[:sub_string] = params[:sub_string] + params[:global_word]
    @object = params[:object_type].constantize.find(params[:object_id])
    @note = Note.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    begin
      global_word = session[:word]
      sub_string = session[:sub_string]
      model_name = params[:note][:object_type]
      post_id = params[:note][:object_id]
      @object = model_name.constantize.find(post_id)
      token = create_token(@object.id)

      @note = Note.new(note_params)
      @note.token = token
      if @note.save
        link = " <a href=\"#{note_path(@note.id)}\"> <i class=\"fa fa-sticky-note pr-5 mr-5\" style=\"padding-right: 10px;\" aria-hidden=\"true\"></i> </a> "
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
    @note = Note.find(params[:id])
  end

  private

  def note_params
    params.require(:note).permit(:note)
  end

  def authorize_notes
    authorize Note
  end

  def create_token(post_id)
    token = Token.new(post_id: post_id, user_id: current_user.id, token_type: 'Note')
    token.save
    token
  end
end
