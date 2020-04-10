class Token < ApplicationRecord


	# validates :token_body, presence: true

	TYPES = {
		note: "Note",
		debate: "Debate",
		question: "Question"
	}
	belongs_to :post 
	belongs_to :layer, optional: true
	has_many :comments
	has_one :question
	has_one :note
	has_one :debate
	belongs_to :user


	def user_name
		User.find(creator_id).full_name
	end
end
