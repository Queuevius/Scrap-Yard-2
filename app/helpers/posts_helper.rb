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
end
