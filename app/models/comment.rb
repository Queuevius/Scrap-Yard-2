class Comment < ApplicationRecord
	belongs_to :token

	def user_name
		User.find(creator_id).full_name
	end
end
