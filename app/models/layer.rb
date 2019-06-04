class Layer < ApplicationRecord
	# Define associations
	belongs_to :layerable, polymorphic: true  
	has_many :tokens


	def creator
		User.find_by_id(self.creator_id) 
	end
end
