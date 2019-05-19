class Comment < ApplicationRecord
	acts_as_votable
	
	belongs_to :token


	validates :com_body, presence: true

	def user_name
		User.find(creator_id).full_name
	end
end
