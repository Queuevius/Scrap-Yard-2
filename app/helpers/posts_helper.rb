module PostsHelper
	def can_edit? post
		current_user.id == post.creator_id || current_user.admin?
	end

	def area_label label_for, tag_name 
		case label_for
		when 'Problem'
			"<span class='label label-danger'>#{tag_name}</span>".html_safe
		when 'Idea'
			"<span class='label label-success'>#{tag_name}</span>".html_safe
		else
			"<span class='label label-info'>#{tag_name}</span>".html_safe
		end
	end

	def bg_color type
		case type
		when 'Problem'
			"#faebd7"
		when 'Idea'
			"#a2ee90"
		else
			"#f0f7ff"
		end
	end

	def add_token( type = "N" )
		"<span class='tkn-n'><strong>#{type}</strong></span>".html_safe
	end


	def add_comment_on_token_form_heading token 
		case token.token_type 
			when "Note"
				"Add a Comment to this Note"
			when "Debate"
				"Add an Arguement"
			when "Question"
				"Give an Answer"
			end
	end

	def add_comment_form_actions token
		case token.token_type 
			when "Note"
				"<button type='submit' class='btn btn-success'>Add Comment</button>".html_safe
			when "Debate"
				"<button type='submit' class='btn btn-success'>I Aggree</button>
				<button type='submit' class='btn btn-danger'>I Disagree</button>
				".html_safe

			when "Question"
				"<button type='submit' class='btn btn-success'>Submit Answer</button>".html_safe
			end

	end
end
