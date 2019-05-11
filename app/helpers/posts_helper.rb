module PostsHelper
	def can_edit? post
		current_user.id == post.creator_id || current_user.admin?
	end

	def area_label post , tag_name 
		label_for = post.post_type 
		area = post.area
		case label_for
		when 'Problem'
			"<a href='/area/#{area.name}'><span class='label label-danger'>#{tag_name}</span></a>".html_safe
		when 'Idea'
			"<a href='/area/#{area.name}'><span class='label label-success'>#{tag_name}</span></a>".html_safe
		else
			"<a href='/area/#{area.name}'><span class='label label-info'>#{tag_name}</span></a>".html_safe
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
				"<button type='submit' class='btn btn-success' onclick='$(\"#polarity\").val(\"yes\");'>I Aggree</button>
				<button type='submit' class='btn btn-danger' onclick='$(\"#polarity\").val(\"no\");' >I Disagree</button>
				<button type='submit' class='btn btn-primary'>I think Otherwise</button>
				".html_safe

			when "Question"
				"<button type='submit' class='btn btn-success'>Submit Answer</button>".html_safe
			end

	end

	def header_title(ptype)
		ptype.try(:pluralize).try(:capitalize).blank? ? "Areas" : ptype.pluralize.capitalize
	end
end


