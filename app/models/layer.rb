class Layer < ApplicationRecord
	# Define associations
	belongs_to :post
	has_many :tokens
end
