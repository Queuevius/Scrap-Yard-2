module ItemsHelper

	def items_label(attr, type)
		case attr 
		when :title
			if type == 'have'
				"Please give a Name to what you Have, and can Give."
			elsif type == 'want'
				"Specify a Name to your Need."
			else
				"Specify a Name to your Item."
			end
		when :details
			if type == 'have'
				"Please tell in details about what you have. This would help people know more about the stuff you have."
			elsif type == 'want'
				"Please tell in details about what your Need."
			else
				"Please tell in details about what your Item."
			end
		end
		
	end




end
