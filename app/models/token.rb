class Token < ApplicationRecord
	
	
	validates :token_body, presence: true

	TYPES = {
		note: "Note",
		debate: "Debate",
		question: "Question"
	}
	belongs_to :post, optional: true
	belongs_to :layer, optional: true
	has_many :comments


	def user_name
		User.find(creator_id).full_name
	end
end
