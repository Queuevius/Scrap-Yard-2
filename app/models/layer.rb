class Layer < ApplicationRecord
	# Define associations
	belongs_to :layerable, polymorphic: true  
	has_many :tokens
end
