class Token < ApplicationRecord
	
	TYPES = {
		note: "Note",
		debate: "Debate",
		question: "Question"
	}
	belongs_to :post 
	belongs_to :layer
	has_many :comments


	def user_name
		User.find(creator_id).full_name
	end
end
